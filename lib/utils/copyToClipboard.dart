import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/alert.dart';

void copyToClipboard(String txt, BuildContext context) {
  HapticFeedback.vibrate();
  Clipboard.setData(ClipboardData(text: txt));
  Alert.show(
    "Text copied to clipboard",
    context,
    textStyle: Theme.of(context).textTheme.bodyText2,
    backgroundColor: Theme.of(context).bottomAppBarColor,
    gravity: Alert.bottom,
    duration: Alert.lengthLong,
  );
}
