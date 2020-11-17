library papercups_flutter;

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:papercups_flutter/classes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'genIframeUrl.dart';

export 'classes.dart';

class PaperCupsWidget extends StatefulWidget {
  final Props props;
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
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: genIframeUrl(widget.props, widget.iframeUrl, context),
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
