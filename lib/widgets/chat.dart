import 'package:flutter/material.dart';
import 'package:papercups_flutter/models/classes.dart';

import '../utils/colorMod.dart';

class ChatMessages extends StatefulWidget {
  final Props props;
  ChatMessages(this.props);
  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        bool userSent = true;
        if (index.isEven) userSent = false;
        var text = "hey.";
        return Row(
          mainAxisAlignment:
              userSent ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (!userSent)
              Padding(
                padding: const EdgeInsets.only(right: 18),
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
              margin: EdgeInsets.symmetric(
                  vertical: 4, horizontal: userSent ? 18 : 0),
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
