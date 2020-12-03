import 'package:flutter/material.dart';
import '../models/classes.dart';
import '../models/message.dart';

import '../utils/colorMod.dart';

class ChatMessages extends StatefulWidget {
  final Props props;
  final List<PapercupsMessage> messages;
  ChatMessages(this.props, this.messages);
  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        var msg = widget.messages[index];
        bool userSent = true;
        if (msg.accountId == widget.props.accountId) userSent = false;
        var text = msg.body;
        return Row(
          mainAxisAlignment:
              userSent ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!userSent)
              Padding(
                padding: EdgeInsets.only(
                  right: 14,
                  left: 14,
                  top: (index == 0) ? 20 : 4,
                ),
                child: CircleAvatar(
                  radius: 16,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: userSent
                    ? widget.props.primaryColor
                    : brighten(Theme.of(context).disabledColor, 80),
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              margin: EdgeInsets.only(
                top: (index == 0) ? 20 : 4,
                bottom: 4,
                left: userSent ? 18 : 0,
                right: userSent ? 18 : 0,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 14,
              ),
              child: SelectableText(
                text,
                style: TextStyle(
                  color: userSent ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
