import 'package:flutter/material.dart';

import 'classes.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.props,
  }) : super(key: key);

  final Props props;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 85,
      width: double.infinity,
      color: props.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            props.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            props.subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(
                0.8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
