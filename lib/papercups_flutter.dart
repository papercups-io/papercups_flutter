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
class PapercupsWidget extends StatefulWidget {
  /// Initialize the props that you will pass on PaperCupsWidget.
  final PapercupsProps props;

  /// Locale for the date, use the locales from the `intl` package.
  /// For example `"es"` or `"en-UK"`.
  final String dateLocale;

  /// Locale for the fuzzy timestamps. Check timeago locales. For example `EsMessages()`.
  /// Check https://github.com/andresaraujo/timeago.dart/tree/master/timeago/lib/src/messages
  /// for the available classes.
  final timeagoLocale;

  PapercupsWidget({
  final Function? closeAction;

  /// Set to true in order to make the send message section float
  final bool floatingSendMessage;

  /// Function to handle message bubble tap action
  final void Function(PapercupsMessage)? onMessageBubbleTap;

    required this.props,
    this.dateLocale = "en-US",
    this.timeagoLocale,
    this.closeAction,
    this.floatingSendMessage = false,
    this.onMessageBubbleTap,
  });

  @override
  _PapercupsWidgetState createState() => _PapercupsWidgetState();
}

class _PapercupsWidgetState extends State<PapercupsWidget> {
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
    if (widget.props.translations.greeting != null &&
        _conversation.messages
                .indexWhere((element) => element.id == "greeting") ==
            -1) {
      _conversation.messages.add(
        PapercupsMessage(
          body: widget.props.translations.greeting,
          sentAt: DateTime.now(),
          createdAt: DateTime.now(),
          accountId: widget.props.accountId,
          user: User(
            displayName: widget.props.translations.companyName,
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
            widget.props.translations.historyFetchErrorText,
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
  void didUpdateWidget(PapercupsWidget oldWidget) {
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
              widget.props.titleStyle?.copyWith(color: Colors.black);
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

  /// This allows a value of type T or T?
  /// to be treated as a value of type T?.
  ///
  /// We use this so that APIs that have become
  /// non-nullable can still be used with `!` and `?`
  /// to support older versions of the API as well.
  T? _ambiguate<T>(T? value) => value;

  void rebuild(void Function() fn, {bool stateMsg = false, animate = false}) {
    _sending = stateMsg;
    if (mounted) setState(fn);
    if (animate && mounted && _conversation.messages.isNotEmpty && _controller.hasClients) {
      _ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) {
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
                    widget.props.translations.noConnectionText,
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
                    label: Text(widget.props.translations.retryButtonLabel),
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
                    widget.props.translations.sendingText,
                    widget.props.translations.sentText,
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
