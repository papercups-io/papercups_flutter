import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:papercups_flutter/models/models.dart';
import 'package:papercups_flutter/utils/colorMod.dart';
import 'package:papercups_flutter/widgets/chat/attachment.dart';
import 'package:papercups_flutter/widgets/chat/timeWidget.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'chatMessage.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.userSent,
    required this.isFirst,
    required this.widget,
    required this.nextMsg,
    required this.msg,
    required this.isLast,
    required this.isTimeSentVisible,
    required this.maxWidth,
    required this.text,
    required this.longDay,
    required this.conatinsAttachment,
    required this.isDownloaded,
  }) : super(key: key);

  final bool userSent;
  final bool isFirst;
  final ChatMessage widget;
  final PapercupsMessage nextMsg;
  final PapercupsMessage msg;
  final bool isLast;
  final bool isTimeSentVisible;
  final double maxWidth;
  final String text;
  final String? longDay;
  final bool conatinsAttachment;
  final bool isDownloaded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              userSent ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!userSent)
              Padding(
                padding: EdgeInsets.only(
                  right: 14,
                  left: 14,
                  top: (isFirst) ? 15 : 4,
                  bottom: 5,
                ),
                child: (widget.msgs!.length == 1 ||
                        nextMsg.userId != msg.userId ||
                        isLast)
                    ? Container(
                        decoration: BoxDecoration(
                          color: widget.props.primaryColor,
                          gradient: widget.props.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.transparent,
                          backgroundImage: (msg.user!.profilePhotoUrl != null)
                              ? NetworkImage(msg.user!.profilePhotoUrl!)
                              : null,
                          child: (msg.user!.profilePhotoUrl != null)
                              ? null
                              : (msg.user != null && msg.user!.fullName == null)
                                  ? Text(
                                      msg.user!.email!
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(color: widget.textColor),
                                    )
                                  : Text(
                                      msg.user!.fullName!
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(color: widget.textColor),
                                    ),
                        ),
                      )
                    : SizedBox(
                        width: 32,
                      ),
              ),
            if (userSent)
              TimeWidget(
                userSent: userSent,
                msg: msg,
                isVisible: isTimeSentVisible,
              ),
            Container(
              decoration: BoxDecoration(
                color: userSent
                    ? widget.props.primaryColor
                    : Theme.of(context).brightness == Brightness.light
                        ? brighten(Theme.of(context).disabledColor, 80)
                        : Color(0xff282828),
                gradient: userSent ? widget.props.primaryGradient : null,
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              margin: EdgeInsets.only(
                top: (isFirst) ? 15 : 4,
                bottom: 4,
                right: userSent ? 18 : 0,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (conatinsAttachment)
                    Attachment(
                      userSent: userSent,
                      props: widget.props,
                      fileName: msg.attachments!.first.fileName ?? "No Name",
                      textColor: widget.textColor,
                      msgHasText: msg.body != null,
                      isDownloaded: isDownloaded,
                    ),
                  if (msg.body != "null")
                    MarkdownBody(
                      data: text,
                      styleSheet: MarkdownStyleSheet(
                          blockquote:
                              TextStyle(decoration: TextDecoration.underline),
                          p: TextStyle(
                            color: userSent
                                ? widget.textColor
                                : Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          a: TextStyle(
                            color: userSent
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          blockquotePadding: EdgeInsets.only(bottom: 2),
                          blockquoteDecoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.5,
                                color: userSent
                                    ? widget.textColor
                                    : Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color ??
                                        Colors.white,
                              ),
                            ),
                          )
                          // blockquotePadding: EdgeInsets.only(left: 14),
                          // blockquoteDecoration: BoxDecoration(
                          //     border: Border(
                          //   left: BorderSide(color: Colors.grey[300]!, width: 4),
                          // )),
                          ),
                    ),
                ],
              ),
            ),
            if (!userSent)
              TimeWidget(
                userSent: userSent,
                msg: msg,
                isVisible: isTimeSentVisible,
              ),
          ],
        ),
        if (!userSent && ((nextMsg.userId != msg.userId) || (isLast)))
          Padding(
              padding: EdgeInsets.only(left: 16, bottom: 5, top: 4),
              child: (msg.user!.fullName == null)
                  ? Text(
                      msg.user!.email!,
                      style: TextStyle(
                        color: Theme.of(context).disabledColor.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    )
                  : Text(
                      msg.user!.fullName!,
                      style: TextStyle(
                        color: Theme.of(context).disabledColor.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    )),
        if (userSent && isLast)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              bottom: 4,
              left: 18,
              right: 18,
            ),
            child: Text(
              widget.sending
                  ? widget.sendingText
                  : "${widget.sentText} ${timeago.format(msg.createdAt!)}",
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        if (isLast || nextMsg.userId != msg.userId)
          SizedBox(
            height: 10,
          ),
        if (longDay != null)
          IgnorePointer(
            ignoring: true,
            child: Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              child: Text(
                longDay!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
