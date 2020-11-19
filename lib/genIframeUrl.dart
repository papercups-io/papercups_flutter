// Import all the required files.
import 'dart:convert';

import 'package:flutter/material.dart';

import 'classes.dart';

/// This function generates the iframe url we're going to pass into the webview.
String genIframeUrl(Props props, String iframeUrl, BuildContext context) {
  /// uriToEncode is used to build the required parameters.
  var uriToEncode = "accountId=${props.accountId}";

  // Check if bool is true.
  if (props.requireEmailUpfront != null) {
    // Add to URI
    uriToEncode +=
        "&requireEmailUpfront=" + _boolToStr(props.requireEmailUpfront);
  }

  // Check if bool is true.
  if (props.scrollEnabled != null) {
    uriToEncode += "&scrollEnabled=" + _boolToStr(props.scrollEnabled);
  }

  // Check if bool is true.
  if (props.showAgentAvailability != null) {
    // Add to URI
    uriToEncode +=
        "&showAgentAvailability=" + _boolToStr(props.showAgentAvailability);
  }

  if (props.agentAvailableText != null) {
    // Add to URI
    uriToEncode += "&agentAvailableText=" + props.agentAvailableText;
  }

  if (props.agentUnavailableText != null) {
    // Add to URI
    uriToEncode += "&agentUnavailableText=" + props.agentUnavailableText;
  }

  if (props.baseUrl != null) {
    // Add to URI
    uriToEncode += "&baseUrl=" + props.baseUrl;
  }

  if (props.greeting != null) {
    // Add to URI
    uriToEncode += "&greeting=" + props.greeting;
  }

  if (props.newMessagePlaceholder != null) {
    // Add to URI
    uriToEncode += "&newMessagePlaceholder=" + props.newMessagePlaceholder;
  }

  if (props.primaryColor != null) {
    // Add to URI
    uriToEncode += "&primaryColor=%23" +
        props.primaryColor
            .withAlpha(255)
            .value
            .toRadixString(16)
            .substring(2)
            .toUpperCase();
  } else {
    // Add to URI, uses default theme if no color is specified.
    uriToEncode += "&primaryColor=%23" +
        Theme.of(context)
            .primaryColor
            .withAlpha(255)
            .value
            .toRadixString(16)
            .substring(2)
            .toUpperCase();
  }

  if (props.subtitle != null) {
    // Add to URI
    uriToEncode += "&subtitle=" + props.subtitle;
  }

  if (props.title != null) {
    // Add to URI
    uriToEncode += "&title=" + props.title;
  }

  if (props.customer != null) {
    /// Add to URI, but first make it into a map, allows to convert into a JSON string. Temporary.
    var map = {
      "name": props.customer.name,
      "email": props.customer.email,
      "external_id": props.customer.externalId,
      // This will spread the custom metadata
      ...props.customer.otherMetadata,
    };
    // Encodes the JSON data and adds it to the URI
    uriToEncode += "&metadata=" + json.encode(map);
  }

  // Add version to URI, latest working is 1.1.1
  uriToEncode += "&version=1.1.1";

  /// Add iframeUrl to create final parameters to be passed to the webview.
  var url = iframeUrl + "?" + uriToEncode;

  // Return url
  return url;
}

/// Internal function, used to convert a bool to the expected Papercups formatting (1 or 0).
String _boolToStr(bool input) {
  if (input)
    return "1";
  else
    return "0";
}
