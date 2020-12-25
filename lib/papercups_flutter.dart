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

  /// Locale for the sent x ago. Check timeago locales. For example `EsMessages()`.
  /// Check https://github.com/andresaraujo/timeago.dart/tree/master/timeago/lib/src/messages
  /// for the available classes.
  final timeagoLocale;

  /// Text to show while message is sending. Default `"Sending..."`
  final String sendingText;

  /// Text to show when the messgae is sent. Default is `"Sent"` time will be added after.
  final String sentText;

  PaperCupsWidget({
    @required this.props,
    this.dateLocale = "en-US",
    this.timeagoLocale,
    this.sendingText = "Sending...",
    this.sentText = "Sent",
  });

  @override
  _PaperCupsWidgetState createState() => _PaperCupsWidgetState();
}

class _PaperCupsWidgetState extends State<PaperCupsWidget> {
  bool _connected = false;
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  PhoenixChannel _conversationChannel;
  List<PapercupsMessage> _messages = [];
  PapercupsCustomer _customer;
  bool _canJoinConversation = false;
  Conversation _conversation;
  ScrollController _controller = ScrollController();
  bool _sending = false;
  bool noConnection = false;

  @override
  void initState() {
    if (widget.props.baseUrl.contains("http"))
      throw "Do not provide a protocol in baseURL";
    if (widget.props.baseUrl.endsWith("/")) throw "Do not provide a trailing /";
    if (widget.props.primaryGradient != null &&
        widget.props.primaryColor != null)
      throw "Expected either primaryColor or primaryGradient to be null";
    if (widget.props.customer != null) {
      setCustomer(PapercupsCustomer(
        email: widget.props.customer.email,
        externalId: widget.props.customer.externalId,
        name: widget.props.customer.name,
      ));
    }
    if (widget.dateLocale != "en-US") {
      initializeDateFormatting().then((_) {
        if (mounted) setState(() {});
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_channel != null) _channel.close();
    if (_conversationChannel != null) _conversationChannel.close();
    if(_socket != null) _socket.dispose();
    if(_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (widget.props.greeting != null) {
      _messages = [
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
      ];
    }
    if (_socket == null) {
      _socket =
          PhoenixSocket("wss://" + widget.props.baseUrl + '/socket/websocket')
            ..connect();
      _subscribeToSocket();
    }
    if (widget.props.customer != null &&
        widget.props.customer.externalId != null &&
        (_customer == null || _customer.createdAt == null) &&
        _conversation == null) {
      getCustomerHistory(
        conversationChannel: _conversationChannel,
        c: _customer,
        messages: _messages,
        rebuild: rebuild,
        setConversationChannel: setConversationChannel,
        setCustomer: setCustomer,
        socket: _socket,
        widget: widget,
      ).then((failed) {
        if (failed) {
          Alert.show(
            "There was an issue retrieving your details. Please try again!",
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
    super.didChangeDependencies();
  }

  void setCustomer(PapercupsCustomer c, {rebuild = false}) {
    _customer = c;
    if (rebuild) setState(() {});
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
    if (animate && mounted && _messages.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.position.maxScrollExtent != null)
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
      _socket,
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
                    "No Connection",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      if (!_socket.isConnected) {
                        _socket.dispose();
                        _socket = PhoenixSocket("wss://" +
                            widget.props.baseUrl +
                            '/socket/websocket')
                          ..connect();
                        _subscribeToSocket();
                      }
                      if (widget.props.customer != null &&
                          widget.props.customer.externalId != null &&
                          (_customer == null || _customer.createdAt == null) &&
                          _conversation == null)
                        getCustomerHistory(
                          conversationChannel: _conversationChannel,
                          c: _customer,
                          messages: _messages,
                          rebuild: rebuild,
                          setConversationChannel: setConversationChannel,
                          setCustomer: setCustomer,
                          socket: _socket,
                          widget: widget,
                        ).then((failed) {
                          if (!failed) {
                            _socket.connect();
                            if (mounted)
                              setState(() {
                                noConnection = false;
                              });
                          }
                        });
                    },
                    icon: Icon(Icons.refresh_rounded),
                    label: Text("Retry"),
                    textColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
                    ),
                  )
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(props: widget.props),
                if (widget.props.showAgentAvailability)
                  AgentAvailability(widget.props),
                Expanded(
                  child: ChatMessages(
                    widget.props,
                    _messages,
                    _controller,
                    _sending,
                    widget.dateLocale,
                    widget.timeagoLocale,
                    widget.sendingText,
                    widget.sentText,
                  ),
                ),
                PoweredBy(),
                (widget.props.requireEmailUpfront &&
                        (_customer == null || _customer.email == null))
                    ? RequireEmailUpfront(setCustomer, widget.props)
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
                        messages: _messages,
                        sending: _sending,
                      ),
              ],
            ),
    );
  }

  void _subscribeToSocket() {
    _socket.closeStream.listen((event) {
      if (mounted)
        setState(() {
          _connected = false;
          noConnection = true;
        });
    });

    _socket.openStream.listen(
      (event) {
        if (noConnection && mounted) {
          rebuild(() {
            noConnection = false;
          }, animate: true);
        }
        return _connected = true;
      },
    );
  }
}
