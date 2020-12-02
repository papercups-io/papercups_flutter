import 'package:flutter/material.dart';
import 'package:papercups_flutter/classes.dart';
import 'package:papercups_flutter/colorMod.dart';

class AgentAvailability extends StatelessWidget {
  final Props props;
  AgentAvailability(this.props);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: brighten(
          props.primaryColor,
          30,
        ),
        border: Border(
          top: BorderSide(
            color: brighten(props.primaryColor, 50),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: Color(0xfff0f0f0),
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              "We're away at the moment.",
              style: TextStyle(
                color: Color(0xccffffff),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
