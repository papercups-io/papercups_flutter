import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/classes.dart';
import '../models/message.dart';

import '../utils/colorMod.dart';

class ChatMessages extends StatelessWidget {
  final Props props;
  final List<PapercupsMessage> messages;
  final bool sending;
  final ScrollController _controller;
  ChatMessages(this.props, this.messages, this._controller, this.sending);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatMessage(
          msgs: messages,
          index: index,
          props: props,
          sending: sending,
        );
      },
    );
  }
}

class ChatMessage extends StatefulWidget {
  const ChatMessage({
    Key key,
    @required this.msgs,
    @required this.index,
    @required this.props,
    @required this.sending,
  }) : super(key: key);

  final List<PapercupsMessage> msgs;
  final int index;
  final Props props;
  final bool sending;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    if (opacity == 0)
      Timer(
          Duration(
            milliseconds: 0,
          ), () {
        setState(() {
          opacity = 1;
        });
      });
    var msg = widget.msgs[widget.index];
    bool userSent = true;
    if (msg.customer == null) userSent = false;
    var text = msg.body;
    return AnimatedOpacity(
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 100),
      opacity: opacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    top: (widget.index == 0) ? 20 : 4,
                  ),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: widget.props.primaryColor,
                    backgroundImage: (msg.user.profilePhotoUrl != null)
                        ? NetworkImage(msg.user.profilePhotoUrl)
                        : null,
                    child: (msg.user.profilePhotoUrl != null)
                        ? null
                        : (msg.user != null && msg.user.fullName == null)
                            ? Text(
                                msg.user.email.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                    color: Theme.of(context).cardColor),
                              )
                            : Text(
                                msg.user.fullName.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                    color: Theme.of(context).cardColor),
                              ),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: userSent
                      ? widget.props.primaryColor
                      : Theme.of(context).brightness == Brightness.light
                          ? brighten(Theme.of(context).disabledColor, 80)
                          : Color(0xff282828),
                  borderRadius: BorderRadius.circular(4),
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                margin: EdgeInsets.only(
                  top: (widget.index == 0) ? 20 : 4,
                  bottom: 4,
                  left: userSent ? 18 : 0,
                  right: userSent ? 18 : 0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 14,
                ),
                child: MarkdownBody(
                  data: text,
                  selectable: true,
                ),
              ),
            ],
          ),
          if (!userSent)
            Padding(
              padding: EdgeInsets.only(left: 16, top: 5),
              child:
                  ((widget.msgs[min(widget.index + 1, widget.msgs.length - 1)]
                                  .customer !=
                              null) ||
                          (widget.msgs.length - 1 == widget.index &&
                              msg.customer == null))
                      ? (msg.user.fullName == null)
                          ? Text(
                              msg.user.email,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.5),
                                fontSize: 14,
                              ),
                            )
                          : Text(
                              msg.user.fullName,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.5),
                                fontSize: 14,
                              ),
                            )
                      : null,
            ),
          if (userSent && widget.index == widget.msgs.length - 1)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                bottom: 4,
                left: 18,
                right: 18,
              ),
              child: Text(
                widget.sending ? "Sending..." : "Sent",
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          if (widget.index == widget.msgs.length - 1)
            SizedBox(
              height: 15,
            )
        ],
      ),
    );
  }
}
