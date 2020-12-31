import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key key,
    @required this.isFirst,
    @required this.widget,
    @required this.nextMsg,
    @required this.msg,
    @required this.isLast,
  }) : super(key: key);

  final bool isFirst;
  final ChatMessage widget;
  final PapercupsMessage nextMsg;
  final PapercupsMessage msg;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 14,
        left: 14,
        top: (isFirst) ? 15 : 4,
        bottom: 5,
      ),
      child: (widget.msgs.length == 1 || nextMsg.userId != msg.userId || isLast)
          ? Container(
              decoration: BoxDecoration(
                color: widget.props.primaryColor,
                gradient: widget.props.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.transparent,
                backgroundImage: (msg.user.profilePhotoUrl != null)
                    ? NetworkImage(msg.user.profilePhotoUrl)
                    : null,
                child: (msg.user.profilePhotoUrl != null)
                    ? null
                    : (msg.user != null && msg.user.fullName == null)
                        ? Text(
                            msg.user.email.substring(0, 1).toUpperCase(),
                            style:
                                TextStyle(color: Theme.of(context).cardColor),
                          )
                        : Text(
                            msg.user.fullName.substring(0, 1).toUpperCase(),
                            style:
                                TextStyle(color: Theme.of(context).cardColor),
                          ),
              ),
            )
          : SizedBox(
              width: 32,
            ),
    );
  }
}