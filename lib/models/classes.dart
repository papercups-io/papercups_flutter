import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:papercups_flutter/models/message.dart';

/// This contains all the possible configurations for the chat widget.
class PapercupsProps {
  /// Required to create the widget, identifies the account.
  final String accountId;

  /// If you are self-hosting papercups, this base URL should be changed.
  final String baseUrl;

  /// This is the data that you will see on your dashboard such as the email or the name of the user.
  final PapercupsCustomerMetadata? customer;

  /// This is the close button displayed in the header section.
  final Widget closeIcon;

  /// Function to handle closing the widget.
  /// If not null, close button will be shown.
  final VoidCallback? closeAction;

  /// This allows you to choose if you want to show your status.
  // final bool showAgentAvailability;

  /// Whether or not to allow scrolling.
  final bool scrollEnabled;

  /// Set to true in order to make the send message section float
  final bool floatingSendMessage;

  /// If you want to require unidentified customers to provide their email before they can message you.
  /// Not recommended for apps.
  final bool requireEmailUpfront;

  /// Message send icon in the chat text field
  final Widget? sendIcon;

  /// Function to handle message bubble tap action.
  final void Function(PapercupsMessage)? onMessageBubbleTap;

  /// This class contains all the styling options used by the widget.
  final PapercupsStyle style;

  /// This contains all the texts that can be displayed by the widget.
  final PapercupsIntl translations;

  // Class definition.
  const PapercupsProps({
    required this.accountId,
    this.baseUrl = 'app.papercups.io',
    this.customer,
    this.closeIcon = const Icon(Icons.close_rounded),
    this.closeAction,
    //this.showAgentAvailability = false,
    this.scrollEnabled = true,
    this.floatingSendMessage = false,
    this.requireEmailUpfront = false,
    this.sendIcon,
    this.onMessageBubbleTap,
    this.style = const PapercupsStyle(),
    this.translations = const PapercupsIntl(),
  });
}

/// Customer Metadata, this contains the customer's information.
class PapercupsCustomerMetadata {
  // Declaration of variables.

  /// This is the name of your user.
  final String? name;

  /// This is the email of the user.
  final String? email;

  /// This is an external ID of the user.
  final String? externalId;

  /// Any extra data you want to pass can be passed as a key-value pair.
  final Map<String, dynamic>? otherMetadata;

  // Class definition.
  const PapercupsCustomerMetadata({
    this.email,
    this.externalId,
    this.name,
    this.otherMetadata,
  });

  String toJsonString() {
    final metadata = otherMetadata ?? {};
    return json.encode(
      {
        'name': name,
        'email': email,
        'external_id': externalId,
        'metadata': metadata,
      },
    );
  }
}

/// This class contains all the styling options used by the widget.
class PapercupsStyle {
  /// Color in which the header is going to be in, if not defined will be primary color used in app.
  final Color? primaryColor;

  /// Gradient to specify, should be used instead of primaryColor, DO NOT USE BOTH.
  final Gradient? primaryGradient;

  /// Color used in the background of the entire widget.
  final Color? backgroundColor;

  /// Text style of the title at the top of the chat widget.
  final TextStyle? titleStyle;

  /// This is the top widget title alignment.
  final TextAlign? titleAlign;

  /// This is the widget sub title text style.
  final TextStyle? subtitleStyle;

  /// Widget header height.
  final double? headerHeight;

  /// Widget header padding.
  final EdgeInsetsGeometry headerPadding;

  /// Widget displayed in the widget when there's no Internet connection.
  final Widget? noConnectionIcon;

  /// Text style of the text displayed in the widget when there's no Internet connection.
  final TextStyle? noConnectionTextStyle;

  /// Input decoration of the require email text field.
  final InputDecoration? requireEmailUpfrontInputDecoration;

  /// Keyboard brightness of the require email text field
  final Brightness? requireEmailUpfrontKeyboardAppearance;

  /// Text style of the require email text field.
  final TextStyle? requireEmailUpfrontInputTextStyle;

  /// Text style of the require email text field hint.
  final TextStyle? requireEmailUpfrontInputHintStyle;

  /// Box decoration of the message text field when `floatingSendMessage` prop is `true`.
  final BoxDecoration? floatingSendMessageBoxDecoration;

  /// Box decoration of the message text field.
  final BoxDecoration? sendMessageBoxDecoration;

  /// Keyboard brightness of the send message text field.
  final Brightness? sendMessageKeyboardAppearance;

  /// Input decoration of the message text field.
  final InputDecoration? sendMessagePlaceholderInputDecoration;

  /// Text style of the message text field input hint text.
  final TextStyle? sendMessagePlaceholderTextStyle;

  /// Text style of the message text field input.
  final TextStyle? sendMessageInputTextStyle;

  /// Box decoration of the bot chat bubbles.
  final BoxDecoration? botBubbleBoxDecoration;

  /// Text style of the bot chat bubbles.
  final TextStyle? botBubbleTextStyle;

  /// Box decoration of the bot attachment (images, files) chat bubbles.
  final BoxDecoration? botAttachmentBoxDecoration;

  /// Text style of the bot attachments file name.
  final TextStyle? botAttachmentTextStyle;

  /// Text style of bot user name displayed below its chat bubbles.
  final TextStyle? botBubbleUsernameTextStyle;

  /// Box decoration of the user chat bubbles.
  final BoxDecoration? userBubbleBoxDecoration;

  /// Text style of the user chat bubbles.
  final TextStyle? userBubbleTextStyle;

  /// Box decoration of the user attachment (images, files) chat bubbles.
  final BoxDecoration? userAttachmentBoxDecoration;

  /// Text style of the user attachments file name.
  final TextStyle? userAttachmentTextStyle;

  /// Text style of the _"Sent x ago"_ (or _"Sending..."_) text displayed below the latest user chat bubble.
  final TextStyle? userBubbleSentAtTextStyle;

  /// Text style of the time stamp displayed (on tap) next to the any chat bubble.
  final TextStyle? chatBubbleTimeTextStyle;

  /// Text style of the date displayed centered in the chat before the chat bubbles of a given day.
  final TextStyle? chatBubbleFullDateTextStyle;

  /// Text style of the alert shown when an attachment is being uploaded.
  final TextStyle? chatUploadingAlertTextStyle;

  /// Background color of the alert shown when an attachment is being uploaded.
  final Color? chatUploadingAlertBackgroundColor;

  /// Text style of the error alert shown when an attachment failed to upload.
  final TextStyle? chatUploadErrorAlertTextStyle;

  /// Background color of the error alert shown when an attachment failed to upload.
  final Color? chatUploadErrorAlertBackgroundColor;

  /// Text style of the alert shown when the chat is displayed but no Internet connection is available.
  final TextStyle? chatNoConnectionAlertTextStyle;

  /// Background color of the alert shown when the chat is displayed but no Internet connection is available.
  final Color? chatNoConnectionAlertBackgroundColor;

  /// Text style of the alert shown when a chat bubble gets long pressed and its text copied.
  final TextStyle? chatCopiedTextAlertTextStyle;

  /// Background color of the alert shown when a chat bubble gets long pressed and its text copied.
  final Color? chatCopiedTextAlertBackgroundColor;

  // Class definition.
  const PapercupsStyle({
    this.primaryColor = const Color(0xFF1890FF),
    this.primaryGradient,
    this.backgroundColor,
    this.titleStyle,
    this.titleAlign = TextAlign.left,
    this.subtitleStyle,
    this.headerHeight,
    this.headerPadding =
        const EdgeInsets.only(top: 16, right: 20, left: 20, bottom: 12),
    this.noConnectionIcon,
    this.noConnectionTextStyle,
    this.requireEmailUpfrontInputDecoration,
    this.requireEmailUpfrontKeyboardAppearance = Brightness.light,
    this.requireEmailUpfrontInputHintStyle = const TextStyle(fontSize: 14),
    this.requireEmailUpfrontInputTextStyle,
    this.floatingSendMessageBoxDecoration,
    this.sendMessageBoxDecoration,
    this.sendMessageKeyboardAppearance = Brightness.light,
    this.sendMessagePlaceholderInputDecoration,
    this.sendMessagePlaceholderTextStyle = const TextStyle(fontSize: 14),
    this.sendMessageInputTextStyle,
    this.botBubbleBoxDecoration,
    this.botBubbleTextStyle,
    this.userBubbleBoxDecoration,
    this.botAttachmentBoxDecoration,
    this.botAttachmentTextStyle,
    this.botBubbleUsernameTextStyle,
    this.userBubbleTextStyle,
    this.userAttachmentBoxDecoration,
    this.userAttachmentTextStyle,
    this.userBubbleSentAtTextStyle,
    this.chatBubbleTimeTextStyle,
    this.chatBubbleFullDateTextStyle,
    this.chatUploadingAlertTextStyle,
    this.chatUploadingAlertBackgroundColor,
    this.chatUploadErrorAlertTextStyle,
    this.chatUploadErrorAlertBackgroundColor,
    this.chatNoConnectionAlertTextStyle,
    this.chatNoConnectionAlertBackgroundColor,
    this.chatCopiedTextAlertTextStyle,
    this.chatCopiedTextAlertBackgroundColor,
  });
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
        'There was an issue retrieving your details. Please try again!',
    this.attachmentUploadErrorText = 'Failed to upload attachment',
    // this.agentUnavailableText  = "We're away at the moment.",
    this.attachmentUploadedText = 'Attachment uploaded',
    this.textCopiedText = 'Text copied to clipboard',
    this.attachmentUploadingText = 'Uploading...',
    this.enterEmailPlaceholder = 'Enter your email',
    // this.agentAvailableText = "We're available.",
    this.newMessagePlaceholder = 'Start typing...',
    this.noConnectionText = 'No Connection',
    this.attachmentNamePlaceholder = 'No Name',
    this.subtitle = 'How can we help you?',
    this.loadingText = 'Loading...',
    this.uploadedText = 'uploaded',
    this.retryButtonLabel = 'Retry',
    this.sendingText = 'Sending...',
    this.imageText = 'Image',
    this.companyName = 'Bot',
    this.fileText = 'File',
    this.sentText = 'Sent',
    this.title = 'Welcome!',
    this.greeting,
  });
}
