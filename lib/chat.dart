import 'package:flutter/material.dart';
import 'package:papercups_flutter/classes.dart';

import 'colorMod.dart';

class ChatMessages extends StatefulWidget {
  final Props props;
  ChatMessages(this.props);
  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          bool userSent = true;
          if (index.isEven) userSent = false;
          var text =
              "Some very long text, which I am sure is super ineteresting but I am not bothered to read.";
          return Container(
            width: double.infinity,
            alignment: userSent ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
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
                vertical: 4,
                horizontal: 16,
              ),
              padding: EdgeInsets.symmetric(
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
          );
        },
      ),
    );
  }
}
