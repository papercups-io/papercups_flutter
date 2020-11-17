import 'dart:convert';

import 'package:flutter/material.dart';

import 'classes.dart';

String genIframeUrl(Props props, String iframeUrl, BuildContext context) {
  var url = iframeUrl + "?accountId=${props.accountId}";

  if (props.requireEmailUpfront != null) {
    url += "&requireEmailUpfront=" + props.requireEmailUpfront.toString();
  }

  if (props.scrollEnabled != null) {
    url += "&scrollEnabled=" + props.scrollEnabled.toString();
  }

  if (props.showAgentAvailability != null) {
    url += "&showAgentAvailability=" + props.showAgentAvailability.toString();
  }

  if (props.agentAvailableText != null) {
    url += "&agentAvailableText=" + props.agentAvailableText;
  }

  if (props.agentUnavailableText != null) {
    url += "&agentUnavailableText=" + props.agentUnavailableText;
  }

  if (props.baseUrl != null) {
    url += "&baseUrl=" + props.baseUrl;
  }

  if (props.greeting != null) {
    url += "&greeting=" + props.greeting;
  }

  if (props.newMessagePlaceholder != null) {
    url += "&newMessagePlaceholder=" + props.newMessagePlaceholder;
  }

  if (props.primaryColor != null) {
    url += "&primaryColor=%23" +
        props.primaryColor
            .withAlpha(255)
            .value
            .toRadixString(16)
            .substring(2)
            .toUpperCase();
  } else {
    url += "&primaryColor=%23" +
        Theme.of(context)
            .primaryColor
            .withAlpha(255)
            .value
            .toRadixString(16)
            .substring(2)
            .toUpperCase();
  }

  if (props.subtitle != null) {
    url += "&subtitle=" + props.subtitle;
  }

  if (props.title != null) {
    url += "&title=" + props.title;
  }

  if (props.customer != null) {
    var map = {
      "name": props.customer.name,
      "email": props.customer.email,
      "externalId": props.customer.externalId,
    };
    url += "&customer=" + json.encode(map);
  }

  if (props.customer.otherMetadata != null){
    url += "&metadata=" + json.encode(props.customer.otherMetadata);
  }

  //url += "&version=1.1.2";
  print(url);
  return url;
}
