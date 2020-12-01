library papercups_flutter;

// Imports.
import 'dart:html';

import 'package:flutter/material.dart';

import 'classes.dart';

// Exports.
export 'classes.dart';

/// Returns the webview which contains the chat. To use it simply call PaperCupsWidget(), making sure to add the props!
class PaperCupsWidget extends StatelessWidget {
  /// Initialize the props that you will pass on PaperCupsWidget.
  final Props props;

  ///Function to run when the close button is clicked. Not supported on web!
  final Function closeAction;

  /// Will be invoked once the view is created, and the page starts to load.
  final Function onStartLoading;

  /// Will be invoked once the page is loaded.
  final Function onFinishLoading;

  /// Will be called if there is some sort of issue loading the page, for example if there are images missing. Should not be invoked normally.
  final Function onError;

  PaperCupsWidget({
    this.closeAction,
    this.onError,
    this.onFinishLoading,
    this.onStartLoading,
    @required this.props,
  });

  @override
  Widget build(BuildContext context) {
    if (props.primaryColor == null) {
      props.primaryColor = Theme.of(context).primaryColor;
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
          ),
          Expanded(
            child: Text("Chat here"),
          ),
          Container(
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
          ),
        ],
      ),
    );
  }
}
