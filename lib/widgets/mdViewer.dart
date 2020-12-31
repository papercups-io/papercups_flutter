import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MdViewer extends StatelessWidget {
  const MdViewer({
    Key key,
    @required this.text,
    @required this.userSent,
  }) : super(key: key);

  final String text;
  final bool userSent;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(
          color: userSent
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
        ),
        a: TextStyle(
          color: userSent
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
        ),
        blockquotePadding: EdgeInsets.only(left: 14),
        blockquoteDecoration: BoxDecoration(
            border: Border(
          left: BorderSide(color: Colors.grey[300], width: 4),
        )),
      ),
    );
  }
}