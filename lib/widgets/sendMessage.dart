import 'package:flutter/material.dart';
import 'package:papercups_flutter/utils/joinConversation.dart';
import '../models/conversation.dart';
import '../models/customer.dart';
import '../utils/getConversationDetails.dart';
import '../utils/getCustomerDetails.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import '../models/classes.dart';

class SendMessage extends StatefulWidget {
  SendMessage({
    Key key,
    this.customer,
    this.setCustomer,
    this.setConversation,
    this.conversationChannel,
    this.conversation,
    this.socket,
    this.setState,
    @required this.props,
  }) : super(key: key);

  final Props props;
  final PapercupsCustomer customer;
  final Function setCustomer;
  final Function setState;
  final Function setConversation;
  final PhoenixChannel conversationChannel;
  final Conversation conversation;
  final PhoenixSocket socket;

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final _msgController = TextEditingController();

  final _msgFocusNode = FocusNode();

  @override
  void dispose() {
    _msgController.dispose();
    _msgFocusNode.dispose();
    super.dispose();
  }

  void triggerSend() {
    _sendMessage(
      _msgFocusNode,
      _msgController,
      widget.customer,
      widget.props,
      widget.setCustomer,
      widget.conversationChannel,
      widget.conversation,
      widget.setConversation,
      widget.conversationChannel,
      widget.socket,
      widget.setState,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        minHeight: 55,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.props.newMessagePlaceholder,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                onSubmitted: (_) => triggerSend,
                controller: _msgController,
                focusNode: _msgFocusNode,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: widget.props.primaryColor,
                shape: const CircleBorder(),
                //padding: const EdgeInsets.all(12),
              ),
              child: Container(
                height: 36,
                width: 36,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              onPressed: triggerSend,
            )
          ],
        ),
      ),
    );
  }
}

void _sendMessage(
  FocusNode fn,
  TextEditingController tc,
  PapercupsCustomer cu,
  Props p,
  Function setCust,
  PhoenixChannel roomChannel,
  Conversation conv,
  Function setConv,
  PhoenixChannel conversationChannel,
  PhoenixSocket socket,
  Function setState,
) {
  final text = tc.text;
  print(text);
  fn.requestFocus();
  tc.clear();

  if (roomChannel == null) {
    getCustomerDetails(p, cu, setCust).then(
      (customerDetails) {
        print(customerDetails.id);
        getConversationDetails(p, conv, customerDetails, setConv).then(
          (conversatioDetails) {
            print("Init success!");
            joinConversationAndListen(
              convId: conversatioDetails.id,
              conversation: conversationChannel,
              socket: socket,
              setState: setState,
            );
          },
        );
      },
    );
  }
}
