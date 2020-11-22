library papercups_flutter;

// Imports.
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'classes.dart';

import "empty.dart" // Empty version
    if (dart.library.js) "webWidget.dart"
    if (dart.library.io) "mobileWidget.dart";

// Exports.
export 'classes.dart';

/// Returns the webview which contains the chat. To use it simply call PaperCupsWidget(), making sure to add the props!
class PaperCupsWidget extends StatefulWidget {
  /// Initialize the props that you will pass on PaperCupsWidget.
  final Props props;

  ///Function to run when the close button is clicked. Not supported on web!
  final Function closeAction;

  /// Initialize the iframeURL, it has a default value of https://chat-widget.papercups.io so no need to change this.
  final String iframeUrl;
  PaperCupsWidget({
    this.iframeUrl = "https://chat-widget.papercups.io",
    this.closeAction,
    @required this.props,
  });

  @override
  _PaperCupsWidgetState createState() => _PaperCupsWidgetState();
}

class _PaperCupsWidgetState extends State<PaperCupsWidget> {
  @override
  void initState() {
    if (kIsWeb && widget.closeAction != null) {
      print("WARNING: closeAction is unsopported on Web!" +
          " More info at https://github.com/flutter/flutter/issues/54027" +
          ". Close button will not be shown.");
    }
    //Enables SurfaceAndroidWebView, much better keyboard support. This is the reason for needing a stateful widget!

    if (widget.props.accountId == null) {
      throw "Account ID must not be null";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ChatWidget(widget: widget),
        if (!kIsWeb && widget.closeAction != null)
          IconButton(
            onPressed: widget.closeAction,
            icon: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
