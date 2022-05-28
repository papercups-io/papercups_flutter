import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

class AgentAvailability extends StatelessWidget {
  final PapercupsProps props;
  const AgentAvailability(this.props, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: brighten(
          props.style.primaryColor!,
          30,
        ),
        border: Border(
          top: BorderSide(
            color: brighten(props.style.primaryColor!, 50),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: const [
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
