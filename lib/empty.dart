import 'package:flutter/material.dart';
import 'papercups_flutter.dart';

/// This widget is used as a stub to make sure that the correct widget is imported depending on the platform.
/// If the platform is unsoported then this widget will render and throw the error.
class ChatWidget extends StatelessWidget {
  /// This replicated the ChatWidget from the web and mobile apps.
  final PaperCupsWidget widget;
  ChatWidget({this.widget});
  @override
  Widget build(BuildContext context) {
    throw "This shouldn't be happening... If you're seeing this message please open an issue!";
  }
}
