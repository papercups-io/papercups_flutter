// Imports
import 'package:flutter/material.dart';

import '../models/classes.dart';

/// This header is shown at the top of the widget and can be customised.
class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.props,
    this.closeAction,
    @required this.textBlack,
  }) : super(key: key);

  final Props props;
  final Function closeAction;
  final bool textBlack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        right: 20,
        left: 20,
        bottom: 12,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: props.primaryColor,
          gradient: props.primaryGradient,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).shadowColor.withOpacity(0.4),
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  props.title,
                  style: TextStyle(
                    color: textBlack ? Colors.black : Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (closeAction != null)
                IconButton(
                  constraints: BoxConstraints(maxHeight: 21),
                  icon: Icon(Icons.close_rounded),
                  onPressed: closeAction,
                  color: textBlack ? Colors.black : Colors.white,
                  padding: EdgeInsets.zero,
                  iconSize: 21,
                  splashRadius: 20,
                )
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Flexible(
            child: Text(
              props.subtitle,
              style: TextStyle(
                color: textBlack
                    ? Colors.black.withOpacity(0.8)
                    : Colors.white.withOpacity(0.8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
