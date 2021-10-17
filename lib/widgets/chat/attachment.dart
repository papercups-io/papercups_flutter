import 'package:flutter/material.dart';
import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/utils/utils.dart';

class Attachment extends StatelessWidget {
  const Attachment(
      {required this.userSent,
      required this.props,
      required this.fileName,
      required this.textColor,
      required this.msgHasText,
      required this.isDownloaded,
      Key? key})
      : super(key: key);

  final bool userSent;
  final Props props;
  final String fileName;
  final Color textColor;
  final bool msgHasText;
  final bool isDownloaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: userSent
            ? darken(props.primaryColor!, 20)
            : Theme.of(context).brightness == Brightness.light
                ? brighten(Theme.of(context).disabledColor, 70)
                : Color(0xff282828),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.only(bottom: msgHasText ? 0 : 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: props.primaryColor,
            child: Icon(
              !isDownloaded
                  ? Icons.download_for_offline_rounded
                  : Icons.attach_file_rounded,
              color: Theme.of(context).canvasColor,
            ),
          ),
          SizedBox(width: 10),
          Text(
            fileName,
            style: TextStyle(
                color: userSent
                    ? textColor
                    : Theme.of(context).textTheme.bodyText1!.color),
          )
        ],
      ),
    );
  }
}
