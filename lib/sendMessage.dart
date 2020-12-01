import 'package:flutter/material.dart';

import 'classes.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({
    Key key,
    @required this.props,
  }) : super(key: key);

  final Props props;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: props.newMessagePlaceholder,
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: props.primaryColor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(
                  18,
                ),
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
