import 'package:flutter/material.dart';

import '../models/classes.dart';

class SendMessage extends StatefulWidget {
  SendMessage({
    Key key,
    @required this.props,
  }) : super(key: key);

  final Props props;

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
                onSubmitted: (_) => _sendMessage(_msgFocusNode, _msgController),
                controller: _msgController,
                focusNode: _msgFocusNode,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: widget.props.primaryColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () => _sendMessage(_msgFocusNode, _msgController),
            )
          ],
        ),
      ),
    );
  }
}

void _sendMessage(FocusNode fn, TextEditingController tc) {
  print(tc.text);
  fn.requestFocus();
  tc.clear();
}
