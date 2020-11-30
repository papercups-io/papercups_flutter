// Import all the required files.
import 'package:flutter/material.dart';

import 'classes.dart';

/// This function generates the iframe url we're going to pass into the webview.
String genIframeUrl(Props props, String iframeUrl, BuildContext context) {
  // Check is a color has been specified.
  if (props.primaryColor == null) {
    // If color is not specified then use the theme's default.
    props.primaryColor = Theme.of(context).primaryColor;
  }

  /// Get parameters as a map object to generate the uri.
  Map<String, String> params = props.toMap();

  // Reomve any null values.
  params.removeWhere((key, value) => value == null);

  // Add the version key.
  params.putIfAbsent("version", () => "1.1.1");

  return Uri.https(iframeUrl, "/", params).toString();
}
