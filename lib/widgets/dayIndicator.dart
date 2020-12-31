import 'package:flutter/material.dart';

class DayIndicator extends StatelessWidget {
  const DayIndicator({
    Key key,
    @required this.longDay,
  }) : super(key: key);

  final String longDay;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        child: Text(
          longDay,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
