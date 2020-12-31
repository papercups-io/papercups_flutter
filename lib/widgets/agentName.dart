import 'package:flutter/material.dart';
import '../models/models.dart';

class AgentName extends StatelessWidget {
  const AgentName({
    Key key,
    @required this.msg,
  }) : super(key: key);

  final PapercupsMessage msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              ));
  }
}