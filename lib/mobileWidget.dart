import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'genIframeUrl.dart';
import 'papercups_flutter.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  /// Props from the main widget
  final PaperCupsWidget widget;

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  void initState() {
    if (!kIsWeb && Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      // Invokes the genIgrameUrl and passes the required paramaters, will return a url, which will be shown on the webview.
      initialUrl:
          genIframeUrl(widget.widget.props, widget.widget.iframeUrl, context),
      // Needs to be unrestricted, default blocks all JS from running.
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (_) {
        widget.widget.onStartLoading();
      },
      onPageFinished: (_) {
        widget.widget.onFinishLoading();
      },
      onWebResourceError: (_) {
        widget.widget.onError();
      },
    );
  }
}
