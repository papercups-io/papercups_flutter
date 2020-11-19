library papercups_flutter;

// Imports.
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:webview_flutter/webview_flutter.dart';

import 'genIframeUrl.dart';
import 'classes.dart';

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
  html.IFrameElement _iframeElement;
  Widget _iframeWidget;

  @override
  void initState() {
    //Enables SurfaceAndroidWebView, much better keyboard support. This is the reason for needing a stateful widget!
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
    if (kIsWeb) _iframeElement = html.IFrameElement();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return LayoutBuilder(
        builder: (ctx, constraints) {
          _iframeElement.height = constraints.maxHeight.toString();
          _iframeElement.width = constraints.maxWidth.toString();
          _iframeElement.src =
              genIframeUrl(widget.props, widget.iframeUrl, context);
          _iframeElement.style.border = 'none';

          // ignore: undefined_prefixed_name
          ui.platformViewRegistry.registerViewFactory(
            'papercupsIFrame',
            (int viewId) => _iframeElement,
          );

          _iframeWidget = HtmlElementView(
            key: UniqueKey(),
            viewType: 'papercupsIFrame',
          );

          return _iframeWidget;
        },
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
