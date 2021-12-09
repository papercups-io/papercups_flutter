![logo](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/logo.svg)

[![pub package](https://img.shields.io/pub/v/papercups_flutter.svg?label=papercups_flutter&color=blue)](https://pub.dev/packages/papercups_flutter) [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart) ![License](https://img.shields.io/github/license/papercups-io/papercups_flutter?color=black) ![GitHub issues](https://img.shields.io/github/issues/papercups-io/papercups_flutter?color=green&label=Issues)


[![likes](https://badges.bar/papercups_flutter/likes)](https://pub.dev/packages/papercups_flutter/score) [![popularity](https://badges.bar/papercups_flutter/popularity)](https://pub.dev/packages/papercups_flutter) [![pub points](https://badges.bar/papercups_flutter/pub%20points)](https://pub.dev/packages/papercups_flutter/score) 

![Demo Chat](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/chatImages.png)

[![button](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/demoButton.svg)](https://papercups-demo.eduardom.dev/)      [![button](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/getPapercups.svg)](https://papercups.io/)


## Installing
To get started simply add `papercups_flutter:` and the latest version to your pubspec.yaml.
Then run `flutter pub get`

🎉 Done, It's that simple.
## Using the widget
Integration with your app requires just a few lines of code, add the following widget wherever you want your papercups chat window to be:
```Dart
import 'package:papercups_flutter/papercups_flutter.dart';

PaperCupsWidget(
  props: Props(
    accountId: "xxxxxxxx-xxxxxxx-xxxx-xxxxxx", //Your account id goes here.
  ),
),
    
```
That should get you up and running in just a few seconds ⚡️.

## Configuration

### Available `PaperCupsWidget` arguments
| Parameter | Type | Value | Default |
| :--- | :--- | :----- | :------ |
| **`dateLocale`** | `String` |Locale for the date, use the locales from the `intl` package.| `"en-US"` |
| **`floatingSendMessage`** | `bool` | Wether to have the message box floating.| `false` |
| **`props`** | `Props` | **Required**, here is where all of the config for the chat is contained.| N/A |
| **`timeagoLocale`** | `dynamic` | Check [`timeago` messages](https://github.com/andresaraujo/timeago.dart/tree/master/timeago/lib/src/messages) for the available classes.| N/A |


### Available `Props` parameters
| Prop | Type | Value | Default |
| :--- | :--- | :----- | :------ |
| **`accountId`** | `String` | **Required**, your Papercups account token | N/A |
| **`baseUrl`** | `String` | The base URL of your API if you're self-hosting Papercups. Ensure you do not include the protocol (https) of a trailing dash (/) | app.papercups.io |
| **`customer`** | `CustomerMetadata` | Identifying information for the customer, including `name`, `email`, `external_id`, and `metadata` (for any custom fields) | N/A |
| **`primaryColor`** | `Color` | The theme color of your chat widget | `Theme.of(context).primaryColor` without alpha |
| **`primaryGradient`** | `Gradient` | Gradient to specify, should be used instead of primaryColor, **DO NOT USE BOTH** | N/A |
| **`requireEmailUpfront`** | `boolean` | If you want to require unidentified customers to provide their email before they can message you | `false` |
| **`translations`** | `PapercupsIntl` | If you want to override the default `EN` translations displayed by the widget | `PapercupsIntl()` |

### Available `CustomerMetaData` parameters
| Parameters | Type | Value | Default |
| :--- | :--- | :----- | :------ |
| **`email`** | `String` | The customer's email| N/A |
| **`externalId`** | `String` | The customer's external ID | N/A |
| **`name`** | `String` | The customer's name | N/A |
| **`otherMetadata`** | `Map<String, String>` | Extra metadata to pass such as OS info | N/A |

### Available `PapercupsIntl` parameters
| Parameters | Type | Value | Default |
| :--- | :--- | :----- | :------ |
<!-- | **`agentAvailableText`** | `String` | This text will be shown if the showAgentAvailability is true and you are online | `"We're available."` |
| **`agentUnavailableText`** | `String` | This text will be shown if the showAgentAvailability is true and you are online | `"We're away at the moment."` | -->
| **`attachmentNamePlaceholder`** | `String` | Text displayed when an attachment doesn't have a file name | `"No Name"` |
| **`attachmentUploadErrorText`** | `String` | Error message displayed when an attachment could not be uploaded | `"Failed to upload attachment"` |
| **`attachmentUploadedText`** | `String` | Text displayed when an attachment has been uploaded | `"Attachment uploaded"` |
| **`attachmentUploadingText`** | `String` | Text displayed when an attachment is been uploaded | `"Uploading..."` |
| **`companyName`** | `String` | Company name to show on greeting | `"Bot"` |
| **`enterEmailPlaceholder`** | `String` | This is the placeholder text in the email input section | `"Enter your email"` |
| **`fileText`** | `String` | Text displayed on the tile where the user decides to upload a file | `"File"` |
| **`greeting`** | `String` | An optional initial message to greet your customers with | N/A |
| **`historyFetchErrorText`** | `String` | Error message displayed when the customer history couldn't be fetched | `"There was an issue retrieving your details. Please try again!` |
| **`imageText`** | `String` | Text displayed on the tile where the user decides to upload an image | `"Image` |
| **`loadingText`** | `String` | Text displayed when the chat is loading | `"Loading..."` |
| **`newMessagePlaceholder`** | `String` | The placeholder text in the new message input | `"Start typing..."` |
| **`noConnectionText`** | `String` | The placeholder text in the new message input | `"No Connection"` |
| **`retryButtonLabel`** | `String` | Label used in the retry button when the chat history couldn't be fetched | `"Retry"` |
| **`sendingText`** | `String` | Text to show while message is sending | `"Sending..."` |
| **`sentText`** | `String` | Text to show when the message is sent | `"Sent"` |
| **`subtitle`** | `String` | The subtitle in the header of your chat widget | `"How can we help you?"` |
| **`textCopiedText`** | `String` | Text displayed when a text has been copied after long press on a chat bubble | `"Text copied to clipboard"` |
| **`title`** | `String` | The title in the header of your chat widget | `"Welcome!"` |
| **`uploadedText`** | `String` | Text displayed after the percentage value of an attachment being uploaded | `"uploaded"` |


## Supporters
[![Stargazers repo roster for @papercups-io/papercups_flutter](https://reporoster.com/stars/papercups-io/papercups_flutter)](https://github.com/papercups-io/papercups_flutter/stargazers) [![Forkers repo roster for @papercups-io/papercups_flutter](https://reporoster.com/forks/papercups-io/papercups_flutter)](https://github.com/papercups-io/papercups_flutter/network/members)
