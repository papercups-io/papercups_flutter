import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/models.dart';

import '../utils/utils.dart';
import 'widgets.dart';

class ChatMessages extends StatelessWidget {
  final Props props;
  final List<PapercupsMessage> messages;
  final bool sending;
  final ScrollController _controller;
  final String locale;
  final timeagoLocale;
  final String sendingText;
  final String sentText;

  ChatMessages(
    this.props,
    this.messages,
    this._controller,
    this.sending,
    this.locale,
    this.timeagoLocale,
    this.sendingText,
    this.sentText, {
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, layout) {
      return Container(
        alignment: Alignment.topCenter,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: ListView.builder(
            controller: _controller,
            physics: props.scrollEnabled
                ? ClampingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatMessage(
                msgs: messages,
                index: index,
                props: props,
                sending: sending,
                locale: locale,
                timeagoLocale: timeagoLocale,
                maxWidth: layout.maxWidth * 0.65,
                sendingText: sendingText,
                sentText: sentText,
              );
            },
          ),
        ),
      );
    });
  }
}

class ChatMessage extends StatefulWidget {
  const ChatMessage({
    Key key,
    @required this.msgs,
    @required this.index,
    @required this.props,
    @required this.sending,
    @required this.maxWidth,
    @required this.locale,
    @required this.timeagoLocale,
    @required this.sendingText,
    @required this.sentText,
  }) : super(key: key);

  final List<PapercupsMessage> msgs;
  final int index;
  final Props props;
  final bool sending;
  final double maxWidth;
  final String locale;
  final timeagoLocale;
  final String sendingText;
  final String sentText;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  double opacity = 0;
  double maxWidth = 0;
  bool isTimeSentVisible = false;
  String longDay;
  Timer timer;
  String text;
  PapercupsMessage nextMsg;
  PapercupsMessage msg;
  bool isFirst;
  bool isLast;
  bool userSent = false;

  @override
  void dispose() {
    if (timer != null) timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    maxWidth = widget.maxWidth;
    setUpMsgs();
    super.initState();
  }

  TimeOfDay senderTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    checkOpacity();
    userSentCheck();
    initLocales();
    initTimer();

    return GestureDetector(
      onTap: () {
        setState(() {
          isTimeSentVisible = true;
        });
      },
      onLongPress: () => copyToClipboard(msg.body, context),
      onTapUp: (_) {
        Timer(
            Duration(
              seconds: 10,
            ), () {
          if (mounted)
            setState(() {
              isTimeSentVisible = false;
            });
        });
      },
      child: AnimatedOpacity(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        opacity: opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  userSent ? MainAxisAlignment.end : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!userSent)
                  UserAvatar(
                    isFirst: isFirst,
                    widget: widget,
                    nextMsg: nextMsg,
                    msg: msg,
                    isLast: isLast,
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
                  child: MdViewer(text: text, userSent: userSent),
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
                  child: (msg.user.fullName == null)
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
                      : "${widget.sentText} ${timeago.format(msg.createdAt)}",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            if (isLast || nextMsg.userId != msg.userId)
              SizedBox(
                height: 10,
              ),
            if (longDay != null) DayIndicator(longDay: longDay),
          ],
        ),
      ),
    );
  }

  void checkOpacity() {
    if (opacity == 0)
      Timer(
          Duration(
            milliseconds: 0,
          ), () {
        if (mounted)
          setState(() {
            opacity = 1;
          });
      });
  }

  void setUpMsgs() {
    msg = widget.msgs[widget.index];
    text = msg.body;
    nextMsg = widget.msgs[min(widget.index + 1, widget.msgs.length - 1)];
    isLast = widget.index == widget.msgs.length - 1;
    isFirst = widget.index == 0;
  }

  void userSentCheck() {
    if (msg.userId != null) userSent = false;
  }

  void initLocales() {
    if (!isLast && (nextMsg.sentAt.day != msg.sentAt.day) && longDay == null) {
      try {
        longDay = DateFormat.yMMMMd(widget.locale).format(nextMsg.sentAt);
      } catch (e) {
        print("ERROR: Error generating localized date!");
        longDay = "Loading...";
      }
    }
    if (userSent && isLast && widget.timeagoLocale != null) {
      timeago.setLocaleMessages(widget.locale, widget.timeagoLocale);
      timeago.setDefaultLocale(widget.locale);
    }
  }

  void initTimer() {
    if (isLast && userSent && timer == null)
      timer = Timer.periodic(Duration(minutes: 1), (timer) {
        if (mounted && timer.isActive) {
          setState(() {});
        }
      });
    if (!isLast && timer != null) timer.cancel();
  }
}
