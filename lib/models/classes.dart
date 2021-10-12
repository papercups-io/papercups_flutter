import 'dart:convert';

import 'package:flutter/material.dart';

/// Customer Metadata, this contains the customer's information.
class CustomerMetadata {
  //Decalration of variables.

  /// This is the name of your user.
  String? name;

  /// This is the email of the user.
  String? email;

  /// This is an external ID of the user.
  String? externalId;

  /// Any extra data you want to pass can be passed as a key-value pair.
  Map<String, String>? otherMetadata;

  //Class definition.
  CustomerMetadata({
    this.email,
    this.externalId,
    this.name,
    this.otherMetadata,
  });

  String toJsonString() {
    var metadata = this.otherMetadata != null ? this.otherMetadata! : {};
    return json.encode(
      {
        "name": this.name,
        "email": this.email,
        "external_id": this.externalId,
        // This will spread the custom metadata
        ...metadata,
      },
    );
  }
}

/// This contains all the possible configurations for the chat widget.
class Props {
  //Decalration of variables.

  /// This is the top section of the widget, normally a welcome text.
  String title;

  /// This is the top widget text style
  TextStyle titleStyle;

  /// This is the top widget title alignment
  TextAlign titleAlign;

  /// This is a smaller piece of text under the title.
  String subtitle;

  /// This is the  subtitle TextStyle
  TextStyle? subtitleStyle;

  /// Color in which the header is going to be in, if not defined will be primary color used in app.
  Color? primaryColor;

  /// Gradient to specify, should be used instead of primaryColor, DO NOT USE BOTH.
  Gradient? primaryGradient;

  /// Required to create the wig¡dget, identifies the account.
  String accountId;

  /// If you are self-hosting papercups, this base URL should be changed.
  String baseUrl;

  /// This is the first message sent by you during the conversation.
  String? greeting;

  /// This is the data that you will see on your dashboard such as the email or the name of the person.
  CustomerMetadata? customer;

  /// This is the placeholder text in the input section.
  String newMessagePlaceholder;

  /// This is the placeholder text in the email input section.
  String enterEmailPlaceholer;

  /// This is the close button in the header section.
  Widget closeIcon;

  /// This text will be shown if the showAgentAvailability is true and you are online.
  //String agentAvailableText;

  /// This text will be shown if the showAgentAvailability is true and you are offline.
  //String agentUnavailableText;

  /// This allows you to choose if you want to show your status.
  //bool showAgentAvailability;

  /// This Will allow you to require an emial to chat. Not recommended for an app.
  bool requireEmailUpfront;

  /// Whether to allow scrolling.
  bool scrollEnabled;

  /// Company name to show on greeting
  String companyName;

  /// header Padding
  EdgeInsetsGeometry headerPadding;

  /// header Height
  double? headerHeight;

  /// message send icon for the chat section.
  Widget? sendIcon;

  //Class definition.
  Props({
    required this.accountId,
    //this.agentAvailableText,
    //this.agentUnavailableText,
    this.baseUrl = "app.papercups.io",
    this.customer,
    this.closeIcon = const Icon(Icons.close_rounded),
    this.greeting,
    this.newMessagePlaceholder = "Start typing...",
    this.primaryColor,
    this.requireEmailUpfront = false,
    this.scrollEnabled = true,
    //this.showAgentAvailability = false,
    this.subtitle = "How can we help you?",
    this.title = "Welcome!",
    this.titleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 21,
      fontWeight: FontWeight.w600,
    ),
    this.subtitleStyle,
    this.titleAlign = TextAlign.left,
    this.headerHeight,
    this.headerPadding = const EdgeInsets.only(
      top: 16,
      right: 20,
      left: 20,
      bottom: 12,
    ),
    this.companyName = "Bot",
    this.primaryGradient,
    this.enterEmailPlaceholer = "Enter your email",
    this.sendIcon,
  });
}
