import 'package:flutter/material.dart';

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
  Color primaryColor;
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
    this.agentAvailableText,
    this.agentUnavailableText,
    this.baseUrl,
    this.customer,
    this.greeting,
    this.newMessagePlaceholder,
    this.primaryColor,
    this.requireEmailUpfront,
    this.scrollEnabled,
    this.showAgentAvailability,
    this.subtitle,
    this.title,
  });
}
