import 'dart:convert';

import 'package:flutter/material.dart';

/// Customer Metadata, this contains the customer's information.
class CustomerMetadata {
  //Declaration of variables.

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

/// This class contains all the text that can be displayed by the widget.
class PapercupsIntl {
  /// Company name to show on greeting.
  final String companyName;

  /// This is the top section of the widget, normally a welcome text.
  final String title;

  /// This is a smaller piece of text under the title.
  final String subtitle;

  /// This is the first message sent by you during the conversation.
  final String? greeting;

  /// Text to show while message is sending.
  ///
  /// Default is `"Sending..."`
  final String sendingText;

  /// Text to show when the message is sent
  ///
  /// Default is `"Sent"` (time will be added after).
  final String sentText;

  /// This is the placeholder text in the input section.
  final String newMessagePlaceholder;

  /// This is the placeholder text in the email input section.
  final String enterEmailPlaceholder;

  /// Error message displayed when the customer history couldn't be fetched.
  final String historyFetchErrorText;

  /// Error message displayed when an attachment could not be uploaded.
  final String attachmentUploadErrorText;

  /// Text displayed when an attachment has been uploaded.
  final String attachmentUploadedText;

  /// Text displayed when an attachment is been uploaded.
  final String attachmentUploadingText;

  /// Text displayed after the percentage value of an attachment being uploaded.
  final String uploadedText;

  /// Text displayed when a text has been copied after long press on a chat bubble.
  final String textCopiedText;

  /// Text displayed when the chat is loading.
  final String loadingText;

  /// Text displayed when an attachment doesn't have a file name.
  final String attachmentNamePlaceholder;

  /// Text displayed when there's no Internet connection.
  final String noConnectionText;

  /// Label used in the retry button when the chat history couldn't be fetched.
  final String retryButtonLabel;

  /// Text displayed on the tile where the user decides to upload a file.
  final String fileText;

  /// Text displayed on the tile where the user decides to upload an image.
  final String imageText;

  /// This text will be shown if the showAgentAvailability is true and you are online.
  //String agentAvailableText;

  /// This text will be shown if the showAgentAvailability is true and you are offline.
  //String agentUnavailableText;

  const PapercupsIntl({
    this.historyFetchErrorText =
        "There was an issue retrieving your details. Please try again!",
    this.attachmentUploadErrorText = 'Failed to upload attachment',
    // this.agentUnavailableText  = "We're away at the moment.",
    this.attachmentUploadedText = 'Attachment uploaded',
    this.textCopiedText = "Text copied to clipboard",
    this.attachmentUploadingText = 'Uploading...',
    this.enterEmailPlaceholder = "Enter your email",
    // this.agentAvailableText = "We're available.",
    this.newMessagePlaceholder = "Start typing...",
    this.noConnectionText = "No Connection",
    this.attachmentNamePlaceholder = "No Name",
    this.subtitle = "How can we help you?",
    this.loadingText = "Loading...",
    this.uploadedText = "uploaded",
    this.retryButtonLabel = "Retry",
    this.sendingText = "Sending...",
    this.imageText = 'Image',
    this.companyName = "Bot",
    this.fileText = 'File',
    this.sentText = "Sent",
    this.title = "Welcome!",
    this.greeting,
  });
}

/// This contains all the possible configurations for the chat widget.
class Props {
  /// This is the top widget text style
  TextStyle titleStyle;

  /// This is the top widget title alignment
  TextAlign titleAlign;

  /// This is the  subtitle TextStyle
  TextStyle? subtitleStyle;

  /// Color in which the header is going to be in, if not defined will be primary color used in app.
  Color? primaryColor;

  /// Gradient to specify, should be used instead of primaryColor, DO NOT USE BOTH.
  Gradient? primaryGradient;

  /// Required to create the widget, identifies the account.
  String accountId;

  /// If you are self-hosting papercups, this base URL should be changed.
  String baseUrl;

  /// This is the data that you will see on your dashboard such as the email or the name of the person.
  CustomerMetadata? customer;

  /// This is the close button in the header section.
  Widget closeIcon;

  /// This allows you to choose if you want to show your status.
  //bool showAgentAvailability;

  /// This Will allow you to require an email to chat. Not recommended for an app.
  bool requireEmailUpfront;

  /// Whether to allow scrolling.
  bool scrollEnabled;

  /// Header padding.
  EdgeInsetsGeometry headerPadding;

  /// Header height.
  double? headerHeight;

  /// Message send icon for the chat section.
  Widget? sendIcon;

  /// This contains all the texts that can be displayed by the widget.
  PapercupsIntl translations;

  // Class definition.
  Props({
    required this.accountId,
    this.baseUrl = "app.papercups.io",
    this.translations = const PapercupsIntl(),
    this.customer,
    this.closeIcon = const Icon(Icons.close_rounded),
    this.primaryColor,
    this.requireEmailUpfront = false,
    this.scrollEnabled = true,
    //this.showAgentAvailability = false,
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
    this.primaryGradient,
    this.sendIcon,
  });
}
