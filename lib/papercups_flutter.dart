library papercups_flutter;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomerMetadata {
  String name;
  String email;
  String externalId;
  Map<String, String> otherMetadata;

  CustomerMetadata({
    this.email,
    this.externalId,
    this.name,
    this.otherMetadata,
  });
}

class Props {
  String title;
  String subtitle;
  String primaryColor;
  String accountId;
  String baseUrl;
  String greeting;
  CustomerMetadata customer;
  String newMessagePlaceholder;
  String agentAvailableText;
  String agentUnavailableText;
  bool showAgentAvailability;
  bool requireEmailUpfront;
  bool scrollEnabled;

  Props({
    @required this.accountId,
    this.agentAvailableText = "We're online",
    this.agentUnavailableText = "We are currently not available",
    this.baseUrl = "https://app.papercups.io",
    this.customer,
    this.greeting = "Welcome!",
    this.newMessagePlaceholder = "Start typing...",
    this.primaryColor = "#13c2c2",
    this.requireEmailUpfront = false,
    this.scrollEnabled = true,
    this.showAgentAvailability = true,
    this.subtitle = "Ask us anything in the chat window below 😊",
    this.title = "Welcome to Papercups!",
  });
}

class PaperCupsWidget extends StatelessWidget {
  final Props props;
  final String iframeUrl;
  PaperCupsWidget({
    this.iframeUrl = "https://chat-widget.papercups.io",
    @required this.props,
  });

  @override
  Widget build(BuildContext context) {
    print(json.encode(props));
    return WebView(
      initialUrl: iframeUrl + json.encode(props),
    );
  }
}
