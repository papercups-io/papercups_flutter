import 'dart:convert';

import 'package:flutter/material.dart';

import 'classes.dart';

String genIframeUrl(Props props, String iframeUrl, BuildContext context) {
  var uriToEncode = "accountId=${props.accountId}";

  if (props.requireEmailUpfront != null) {
    uriToEncode +=
        "&requireEmailUpfront=" + props.requireEmailUpfront.toString();
  }

  if (props.scrollEnabled != null) {
    uriToEncode += "&scrollEnabled=" + props.scrollEnabled.toString();
  }

  if (props.showAgentAvailability != null) {
    uriToEncode +=
        "&showAgentAvailability=" + props.showAgentAvailability.toString();
  }

  if (props.agentAvailableText != null) {
    uriToEncode += "&agentAvailableText=" + props.agentAvailableText;
  }

  if (props.agentUnavailableText != null) {
    uriToEncode += "&agentUnavailableText=" + props.agentUnavailableText;
  }

  if (props.baseUrl != null) {
    uriToEncode += "&baseUrl=" + props.baseUrl;
  }

  if (props.greeting != null) {
    uriToEncode += "&greeting=" + props.greeting;
  }

  if (props.newMessagePlaceholder != null) {
    uriToEncode += "&newMessagePlaceholder=" + props.newMessagePlaceholder;
  }

  if (props.primaryColor != null) {
    uriToEncode += "&primaryColor=%23" +
        props.primaryColor
            .withAlpha(255)
            .value
            .toRadixString(16)
            .substring(2)
            .toUpperCase();
  } else {
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
    uriToEncode += "&subtitle=" + props.subtitle;
  }

  if (props.title != null) {
    uriToEncode += "&title=" + props.title;
  }

  if (props.customer != null) {
    var map = {
      "name": props.customer.name,
      "email": props.customer.email,
      "externalId": props.customer.externalId,
      ...props.customer.otherMetadata,
    };
    uriToEncode += "&metadata=" + json.encode(map);
  }

  uriToEncode += "&version=1.1.1";
  print(uriToEncode);

  var url = iframeUrl + "?" + uriToEncode;
  print(url);
  return url;
}
