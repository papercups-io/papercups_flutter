// Imports
import 'package:flutter/material.dart';

import '../../models/classes.dart';

/// This header is shown at the top of the widget and can be customised.
class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.props,
    this.closeAction,
  }) : super(key: key);

  final Props props;
  final Function? closeAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: props.headerPadding,
      width: double.infinity,
      height: props.headerHeight,
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
                child: Text(props.translations.title,
                    style: props.titleStyle, textAlign: props.titleAlign),
              ),
              if (closeAction != null)
                IconButton(
                  constraints: BoxConstraints(maxHeight: 21),
                  icon: props.closeIcon,
                  onPressed: closeAction as void Function()?,
                  color: props.titleStyle.color,
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
              props.translations.subtitle,
              style: props.subtitleStyle ??
                  TextStyle(
                    color: props.titleStyle.color?.withOpacity(0.8),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
