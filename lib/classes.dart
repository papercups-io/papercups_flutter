import 'package:flutter/material.dart';

/// Customer Metadata, this contains the customer's information.
class CustomerMetadata {
  //Decalration of variables.
  String name;
  String email;
  String externalId;
  Map<String, String> otherMetadata;

  //Class definition.
  CustomerMetadata({
    this.email,
    this.externalId,
    this.name,
    this.otherMetadata,
  });
}

/// This contains all the possible configurations for the chat widget.
class Props {
  //Decalration of variables.
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

  //Class definition.
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
