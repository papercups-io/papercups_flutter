// Imports
import 'package:flutter/material.dart';

import '../../models/classes.dart';

/// This header is shown at the top of the widget and can be customised.
class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.props,
    this.closeAction,
    required this.textColor,
  }) : super(key: key);

  final PapercupsProps props;
  final VoidCallback? closeAction;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: props.style.headerPadding,
      width: double.infinity,
      height: props.style.headerHeight,
      decoration: BoxDecoration(
          color: props.style.primaryColor,
          gradient: props.style.primaryGradient,
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
                    style: props.style.titleStyle ??
                        TextStyle(
                          color: textColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: props.style.titleAlign),
              ),
              if (closeAction != null)
                IconButton(
                  constraints: const BoxConstraints(maxHeight: 21),
                  icon: props.closeIcon,
                  onPressed: closeAction,
                  color: props.style.titleStyle?.color ?? textColor,
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
              style: props.style.subtitleStyle ??
                  TextStyle(
                    color: (props.style.titleStyle?.color ?? textColor)
                        .withOpacity(0.8),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
