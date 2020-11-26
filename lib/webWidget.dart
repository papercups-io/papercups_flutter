import 'package:flutter/material.dart';
import 'genIframeUrl.dart';
import 'papercups_flutter.dart';
import 'platformViewStub.dart' if (dart.library.html) 'dart:ui' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  /// Props from the main widget
  final PaperCupsWidget widget;

  @override
  Widget build(BuildContext context) {
    widget.onStartLoading();
    return LayoutBuilder(
      builder: (ctx, constraints) {
        html.IFrameElement _iframeElement;

        // Iframe configuration.
        _iframeElement = html.IFrameElement();
        _iframeElement.height = constraints.maxHeight.toString();
        _iframeElement.width = constraints.maxWidth.toString();
        _iframeElement.src =
            genIframeUrl(widget.props, widget.iframeUrl, context);
        _iframeElement.style.border = 'none';

        // Invocation of funtions is an event is sent through the stream.
        _iframeElement.onLoad.listen((event) {
          widget.onFinishLoading();
        });
        _iframeElement.onError.listen((event) {
          widget.onError(null);
        });

        // ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory(
          'papercupsIFrame',
          (int viewId) => _iframeElement,
        );

        // We use const here to stop the widget from rebuilding if setState
        // is called as the widget does not change.
        return const HtmlElementView(
          key: Key("iframepaperCups"),
          viewType: 'papercupsIFrame',
        );
      },
    );
  }
}
