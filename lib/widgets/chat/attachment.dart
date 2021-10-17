import 'package:flutter/material.dart';
import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/utils/utils.dart';

class Attachment extends StatelessWidget {
  const Attachment({required this.userSent, required this.props, Key? key})
      : super(key: key);

  final bool userSent;
  final Props props;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: userSent
            ? brighten(props.primaryColor!, 20)
            : Theme.of(context).brightness == Brightness.light
                ? brighten(Theme.of(context).disabledColor, 80)
                : Color(0xff282828),
      ),
    );
  }
}
