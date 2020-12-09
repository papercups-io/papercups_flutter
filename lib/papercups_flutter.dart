library papercups_flutter;

// Imports.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:papercups_flutter/models/conversation.dart';
import 'package:papercups_flutter/models/customer.dart';
import 'package:papercups_flutter/utils/intitChannels.dart';
import 'package:papercups_flutter/widgets/agentAvaiability.dart';
import 'package:papercups_flutter/widgets/chat.dart';
import 'package:papercups_flutter/widgets/poweredBy.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'models/classes.dart';
import 'models/message.dart';
import 'widgets/sendMessage.dart';
import 'widgets/header.dart';

// Exports.
export 'models/classes.dart';

/// Returns the webview which contains the chat. To use it simply call PaperCupsWidget(), making sure to add the props!
class PaperCupsWidget extends StatefulWidget {
  /// Initialize the props that you will pass on PaperCupsWidget.
  final Props props;

  PaperCupsWidget({
    @required this.props,
  });

  @override
  _PaperCupsWidgetState createState() => _PaperCupsWidgetState();
}

class _PaperCupsWidgetState extends State<PaperCupsWidget> {
  bool _connected = false;
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  PhoenixChannel _conversationChannel;
  List<PapercupsMessage> messages = [];
  PapercupsCustomer customer;
  bool _canJoinConversation = false;
  Conversation _conversation;
  ScrollController _controller = ScrollController();
  bool _sending = false;

  @override
  void initState() {
    if (widget.props.baseUrl.contains("http"))
      throw "Do not provide a protocol in baseURL";
    if (widget.props.baseUrl.endsWith("/")) throw "Do not provide a trailing /";
    super.initState();
  }

  @override
  void dispose() {
    _channel.close();
    _conversationChannel.close();
    _socket.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (widget.props.greeting != null) {
      messages = [
        PapercupsMessage(
          body: widget.props.greeting,
          sentAt: DateTime.now(),
          accountId: widget.props.accountId,
          user: User(
            fullName: widget.props.companyName,
          ),
        ),
      ];
    }
    if (_socket == null) {
      _socket =
          PhoenixSocket("wss://" + widget.props.baseUrl + '/socket/websocket')
            ..connect();

      _socket.closeStream.listen((event) {
        setState(() => _connected = false);
      });

      _socket.openStream.listen(
        (event) {
          setState(
            () {
              return _connected = true;
            },
          );
        },
      );
    }
    super.didChangeDependencies();
  }

  void setCustomer(PapercupsCustomer c) {
    customer = c;
  }

  void setConversation(Conversation c) {
    _conversation = c;
  }

  void setConversationChannel(PhoenixChannel c) {
    setState(() {
      _conversationChannel = c;
    });
  }

  void rebuild(void Function() fn, {bool stateMsg = false}) {
    _sending = stateMsg;
    setState(fn);
    Timer(Duration(milliseconds: 1), () {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
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
    if (widget.props.primaryColor == null) {
      widget.props.primaryColor = Theme.of(context).primaryColor;
    }
    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Header(props: widget.props),
          if (widget.props.showAgentAvailability)
            AgentAvailability(widget.props),
          Expanded(
            child: ChatMessages(widget.props, messages, _controller, _sending),
          ),
          PoweredBy(),
          SendMessage(
            props: widget.props,
            customer: customer,
            setCustomer: setCustomer,
            setConversation: setConversation,
            conversationChannel: _conversationChannel,
            setConversationChannel: setConversationChannel,
            conversation: _conversation,
            socket: _socket,
            setState: rebuild,
            messages: messages,
            sending: _sending,
          ),
        ],
      ),
    );
  }
}
