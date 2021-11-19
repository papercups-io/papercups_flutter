import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:open_file/open_file.dart';
import 'package:papercups_flutter/utils/fileInteraction/downloadFile.dart';
import 'package:papercups_flutter/utils/fileInteraction/handleDownloads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../models/models.dart';

import 'chatBubble.dart';
import '../widgets.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage({
    Key? key,
    required this.msgs,
    required this.index,
    required this.props,
    required this.sending,
    required this.maxWidth,
    required this.locale,
    required this.timeagoLocale,
    required this.sendingText,
    required this.sentText,
    required this.textColor,
    this.onMessageBubbleTap,
  }) : super(key: key);

  final List<PapercupsMessage>? msgs;
  final int index;
  final Props props;
  final bool sending;
  final double maxWidth;
  final String locale;
  final timeagoLocale;
  final String sendingText;
  final String sentText;
  final Color textColor;
  final void Function(PapercupsMessage)? onMessageBubbleTap;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  double opacity = 0;
  double maxWidth = 0;
  bool isTimeSentVisible = false;
  String? longDay;
  Timer? timer;

  bool containsAttachment = false;

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    maxWidth = widget.maxWidth;
    super.initState();
  }

  TimeOfDay senderTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
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
    var msg = widget.msgs![widget.index];

    bool userSent = true;
    if (msg.userId != null) userSent = false;

    var text = msg.body ?? "";
    if (msg.fileIds != null && msg.fileIds!.isNotEmpty) {
      containsAttachment = true;
    }
    var nextMsg = widget.msgs![min(widget.index + 1, widget.msgs!.length - 1)];
    var isLast = widget.index == widget.msgs!.length - 1;
    var isFirst = widget.index == 0;

    if (!isLast &&
        (nextMsg.sentAt!.day != msg.sentAt!.day) &&
        longDay == null) {
      try {
        longDay = DateFormat.yMMMMd(widget.locale).format(nextMsg.sentAt!);
      } catch (e) {
        print("ERROR: Error generating localized date!");
        // TODO: Internationalize this
        longDay = widget.props.loadingMessage;
      }
    }
    if (userSent && isLast && widget.timeagoLocale != null) {
      timeago.setLocaleMessages(widget.locale, widget.timeagoLocale);
      timeago.setDefaultLocale(widget.locale);
    }
    if (isLast && userSent && timer == null)
      timer = Timer.periodic(Duration(minutes: 1), (timer) {
        if (mounted && timer.isActive) {
          setState(() {});
        }
      });
    if (!isLast && timer != null) timer!.cancel();
    return GestureDetector(
      onTap: () async {
        setState(() {
          isTimeSentVisible = true;
        });
        if (widget.onMessageBubbleTap != null) widget.onMessageBubbleTap!(msg);
      },
      onLongPress: () {
        HapticFeedback.vibrate();
        final data = ClipboardData(text: text);
        Clipboard.setData(data);
        // TODO: Internationalize this
        Alert.show(
          widget.props.textCopiedMessage,
          context,
          textStyle: Theme.of(context).textTheme.bodyText2,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          gravity: Alert.bottom,
          duration: Alert.lengthLong,
        );
      },
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
        child: ChatBubble(
          userSent: userSent,
          isFirst: isFirst,
          widget: widget,
          nextMsg: nextMsg,
          msg: msg,
          isLast: isLast,
          isTimeSentVisible: isTimeSentVisible,
          maxWidth: maxWidth,
          text: text,
          longDay: longDay,
          containsAttachment: containsAttachment,
        ),
      ),
    );
  }
}
