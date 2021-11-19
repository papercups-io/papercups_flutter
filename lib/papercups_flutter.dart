library papercups_flutter;

// Imports.
import 'package:flutter/material.dart';
import 'utils/utils.dart';
import 'widgets/widgets.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'models/models.dart';
import 'package:intl/date_symbol_data_local.dart';

// Exports.
export 'models/classes.dart';
export 'package:timeago/timeago.dart';

/// Returns the webview which contains the chat. To use it simply call PaperCupsWidget(), making sure to add the props!
class PaperCupsWidget extends StatefulWidget {
  /// Initialize the props that you will pass on PaperCupsWidget.
  final Props props;

  /// Locale for the date, use the locales from the `intl` package.
  /// For example `"es"` or `"en-UK"`.
  final String dateLocale;

  /// Locale for the fuzzy timestamps. Check timeago locales. For example `EsMessages()`.
  /// Check https://github.com/andresaraujo/timeago.dart/tree/master/timeago/lib/src/messages
  /// for the available classes.
  final timeagoLocale;

  /// Text to show while message is sending. Default `"Sending..."`
  final String sendingText;

  /// Text to show when the messgae is sent. Default is `"Sent"` time will be added after.
  final String sentText;

  /// If not null, close button will be shown.
  final Function? closeAction;

  /// Set to true in order to make the send message section float
  final bool floatingSendMessage;

  /// Function to handle message bubble tap action
  final void Function(PapercupsMessage)? onMessageBubbleTap;

  PaperCupsWidget({
    required this.props,
    this.dateLocale = "en-US",
    this.timeagoLocale,
    this.sendingText = "Sending...",
    this.sentText = "Sent",
    this.closeAction,
    this.floatingSendMessage = false,
    this.onMessageBubbleTap,
  });

  @override
  _PaperCupsWidgetState createState() => _PaperCupsWidgetState();
}

class _PaperCupsWidgetState extends State<PaperCupsWidget> {
  bool _connected = false;
  PhoenixSocket? _socket;
  PhoenixChannel? _channel;
  PhoenixChannel? _conversationChannel;
  PapercupsCustomer? _customer;
  bool _canJoinConversation = false;
  Conversation _conversation = Conversation(messages: []);
  ScrollController _controller = ScrollController();
  bool _sending = false;
  bool noConnection = false;
  Color textColor = Colors.white;

  @override
  void dispose() {
    if (_channel != null) _channel!.close();
    if (_conversationChannel != null) _conversationChannel!.close();
    if (_socket != null) _socket!.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (widget.props.greeting != null &&
        _conversation.messages
                .indexWhere((element) => element.id == "greeting") ==
            -1) {
      _conversation.messages.add(
        PapercupsMessage(
          body: widget.props.greeting,
          sentAt: DateTime.now(),
          createdAt: DateTime.now(),
          accountId: widget.props.accountId,
          user: User(
            fullName: widget.props.companyName,
          ),
          userId: 0,
          id: "greeting",
        ),
      );
    }
    if (_socket == null) {
      _socket =
          PhoenixSocket("wss://" + widget.props.baseUrl + '/socket/websocket')
            ..connect();
      _subscribeToSocket();
    }
    if (widget.props.customer != null &&
        widget.props.customer!.externalId != null &&
        (_customer == null || _customer!.createdAt == null) &&
        _conversation.id == null &&
        _conversation.messages.length <= 1) {
      getCustomerHistory(
        conversationChannel: _conversationChannel,
        c: _customer,
        messages: _conversation.messages,
        rebuild: rebuild,
        setConversationChannel: setConversationChannel,
        setCustomer: setCustomer,
        socket: _socket,
        props: widget.props,
      ).then((failed) {
        if (failed) {
          Alert.show(
            widget.props.historyFetchErrorMessage,
            context,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            textStyle: Theme.of(context).textTheme.bodyText2,
            gravity: Alert.bottom,
            duration: Alert.lengthLong,
          );
          setState(() {
            noConnection = true;
          });
        }
      });
    }
    if ((widget.props.primaryColor != null &&
            widget.props.primaryColor!.computeLuminance() > 0.5) ||
        (widget.props.primaryGradient != null &&
            widget.props.primaryGradient!.colors[0].computeLuminance() > 0.5) ||
        (widget.props.primaryColor == null &&
            Theme.of(context).primaryColor.computeLuminance() > 0.5))
      textColor = Colors.black;
    if (widget.props.baseUrl.contains("http"))
      throw "Do not provide a protocol in baseURL";
    if (widget.props.baseUrl.endsWith("/")) throw "Do not provide a trailing /";
    if (widget.props.primaryGradient != null &&
        widget.props.primaryColor != null)
      throw "Expected either primaryColor or primaryGradient to be null";
    if (widget.props.customer != null) {
      setCustomer(PapercupsCustomer(
        email: widget.props.customer!.email,
        externalId: widget.props.customer!.externalId,
        name: widget.props.customer!.name,
      ));
    }
    if (widget.dateLocale != "en-US") {
      initializeDateFormatting().then((_) {
        if (mounted) setState(() {});
      });
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(PaperCupsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.props.primaryColor != widget.props.primaryColor) {
      if ((widget.props.primaryColor != null &&
              widget.props.primaryColor!.computeLuminance() > 0.5) ||
          (widget.props.primaryGradient != null &&
              widget.props.primaryGradient!.colors[0].computeLuminance() >
                  0.5) ||
          (widget.props.primaryColor == null &&
              Theme.of(context).primaryColor.computeLuminance() > 0.5)) {
        textColor = Colors.black;
        if (widget.props.titleStyle == null)
          widget.props.titleStyle =
              widget.props.titleStyle.copyWith(color: Colors.black);
      } else {
        textColor = Colors.white;
      }
    }
  }

  void setCustomer(PapercupsCustomer c, {rebuild = false}) {
    if (_customer != c) {
      _customer = c;
      if (rebuild) setState(() {});
    }
  }

  void setConversation(Conversation c) {
    _conversation = c;
  }

  void setConversationChannel(PhoenixChannel c) {
    _conversationChannel = c;
  }

  void rebuild(void Function() fn, {bool stateMsg = false, animate = false}) {
    _sending = stateMsg;
    if (mounted) setState(fn);
    if (animate &&
        mounted &&
        _conversation.messages.isNotEmpty &&
        WidgetsBinding.instance != null &&
        _controller.hasClients) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 300),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initChannels(
      _connected,
      _socket!,
      _channel,
      widget.props,
      _canJoinConversation,
      rebuild,
    );
    if (widget.props.primaryColor == null &&
        widget.props.primaryGradient == null)
      widget.props.primaryColor = Theme.of(context).primaryColor;
    return Container(
      color: Theme.of(context).canvasColor,
      child: noConnection
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(
                    // TODO: Internationalize this
                    widget.props.noConnectionMessage,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (!_socket!.isConnected) {
                        _socket!.dispose();
                        _socket = PhoenixSocket("wss://" +
                            widget.props.baseUrl +
                            '/socket/websocket')
                          ..connect();
                        _subscribeToSocket();
                      }
                      if (widget.props.customer != null &&
                          widget.props.customer!.externalId != null &&
                          (_customer == null || _customer!.createdAt == null) &&
                          _conversation.id == null)
                        getCustomerHistory(
                          conversationChannel: _conversationChannel,
                          c: _customer,
                          messages: _conversation.messages,
                          rebuild: rebuild,
                          setConversationChannel: setConversationChannel,
                          setCustomer: setCustomer,
                          socket: _socket,
                          props: widget.props,
                        ).then((failed) {
                          if (!failed) {
                            _socket!.connect();
                            if (mounted)
                              setState(() {
                                noConnection = false;
                              });
                          }
                        });
                    },
                    icon: Icon(Icons.refresh_rounded),
                    // TODO: Internationalize this
                    label: Text(widget.props.retryButtonLabel),
                  )
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(
                  props: widget.props,
                  closeAction: widget.closeAction,
                ),
                // if (widget.props.showAgentAvailability)
                //   AgentAvailability(widget.props),
                Expanded(
                  child: ChatMessages(
                    widget.props,
                    _conversation.messages,
                    _controller,
                    _sending,
                    widget.dateLocale,
                    widget.timeagoLocale,
                    widget.sendingText,
                    widget.sentText,
                    textColor,
                    widget.onMessageBubbleTap,
                  ),
                ),
                if (!widget.floatingSendMessage) PoweredBy(),
                Container(
                  margin: widget.floatingSendMessage
                      ? EdgeInsets.only(
                          right: 15,
                          left: 15,
                        )
                      : null,
                  decoration: widget.floatingSendMessage
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey.withOpacity(0.4)
                                    : Colors.black.withOpacity(0.8),
                              )
                            ])
                      : BoxDecoration(),
                  clipBehavior:
                      widget.floatingSendMessage ? Clip.antiAlias : Clip.none,
                  child: (widget.props.requireEmailUpfront &&
                          (_customer == null || _customer!.email == null))
                      ? RequireEmailUpfront(setCustomer, widget.props,
                          textColor, !widget.floatingSendMessage)
                      : SendMessage(
                          props: widget.props,
                          customer: _customer,
                          setCustomer: setCustomer,
                          setConversation: setConversation,
                          conversationChannel: _conversationChannel,
                          setConversationChannel: setConversationChannel,
                          conversation: _conversation,
                          socket: _socket,
                          setState: rebuild,
                          messages: _conversation.messages,
                          sending: _sending,
                          textColor: textColor,
                          showDivider: !widget.floatingSendMessage,
                        ),
                ),
                if (widget.floatingSendMessage)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: PoweredBy(),
                  ),
              ],
            ),
    );
  }

  void _subscribeToSocket() {
    _socket!.closeStream.listen((event) {
      if (mounted)
        setState(() {
          _connected = false;
          noConnection = true;
        });
    });

    _socket!.openStream.listen(
      (event) {
        if (noConnection && mounted) {
          rebuild(() {
            noConnection = false;
          }, animate: true);
        }
      },
    );
  }
}
