library papercups_flutter;

// Imports.
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:webview_flutter/webview_flutter.dart';

import 'genIframeUrl.dart';
import 'classes.dart';
import 'webWidget.dart';

// Exports.
export 'classes.dart';

/// Returns the webview which contains the chat. To use it simply call PaperCupsWidget(), making sure to add the props!
class PaperCupsWidget extends StatefulWidget {
  /// Initialize the props that you will pass on PaperCupsWidget.
  final Props props;

  /// Initialize the iframeURL, it has a default value of https://chat-widget.papercups.io so no need to change this.
  final String iframeUrl;
  PaperCupsWidget({
    this.iframeUrl = "https://chat-widget.papercups.io",
    @required this.props,
  });

  @override
  _PaperCupsWidgetState createState() => _PaperCupsWidgetState();
}

class _PaperCupsWidgetState extends State<PaperCupsWidget> {
  @override
  void initState() {
    //Enables SurfaceAndroidWebView, much better keyboard support. This is the reason for needing a stateful widget!
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebWidget(
        widget: widget,
      );
    } else
      return WebView(
        // Invokes the genIgrameUrl and passes the required paramaters, will return a url, which will be shown on the webview.
        initialUrl: genIframeUrl(widget.props, widget.iframeUrl, context),
        // Needs to be unrestricted, default blocks all JS from running.
        javascriptMode: JavascriptMode.unrestricted,
      );
  }
}
