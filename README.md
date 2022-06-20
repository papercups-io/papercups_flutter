![logo](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/logo.svg)

[![pub package](https://img.shields.io/pub/v/papercups_flutter.svg?label=papercups_flutter&color=blue)](https://pub.dev/packages/papercups_flutter) [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart) ![License](https://img.shields.io/github/license/papercups-io/papercups_flutter?color=black) ![GitHub issues](https://img.shields.io/github/issues/papercups-io/papercups_flutter?color=green&label=Issues)


[![likes](https://badges.bar/papercups_flutter/likes)](https://pub.dev/packages/papercups_flutter/score) [![popularity](https://badges.bar/papercups_flutter/popularity)](https://pub.dev/packages/papercups_flutter) [![pub points](https://badges.bar/papercups_flutter/pub%20points)](https://pub.dev/packages/papercups_flutter/score) 

![Demo Chat](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/chatImages.png)

[![button](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/demoButton.svg)](https://papercups-demo.eduardom.dev/)      [![button](https://raw.githubusercontent.com/papercups-io/papercups_flutter/main/images/getPapercups.svg)](https://papercups.io/)

Compatible with **all** platforms: Windows, Android, Linux, MacOS, and iOS

## Installing
To get started simply add `papercups_flutter:` and the latest version to your pubspec.yaml.
Then run `flutter pub get`

🎉 Done, It's that simple.
## Using the widget
Integration with your app requires just a few lines of code, add the following widget wherever you want your papercups chat window to be:
```Dart
import 'package:papercups_flutter/papercups_flutter.dart';

PapercupsWidget(
  props: PapercupsProps(
    accountId: "xxxxxxxx-xxxxxxx-xxxx-xxxxxx", //Your account id goes here.
  ),
),
    
```
That should get you up and running in just a few seconds ⚡️.

## Configuration

### Available `PapercupsWidget` arguments
| Parameter           | Type      | Value                                                                                                                                    | Default   |
| :------------------ | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------- | :-------- |
| **`props`**         | `PapercupsProps`   | **Required**. This is where all of the config for the chat is contained.                                                                 | N/A       |
| **`dateLocale`**    | `String`  | Locale for the date, use the locales from the `intl` package.                                                                            | `"en-US"` |
| **`timeagoLocale`** | `dynamic` | Check [`timeago` messages](https://github.com/andresaraujo/timeago.dart/tree/master/packages/timeago/lib/src/messages) for the available classes. | N/A       |


### Available `PapercupsProps` parameters
| Prop                      | Type                              | Value                                                                                                                             | Default              |
| :------------------------ | :-------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------- | :------------------- |
| **`accountId`**           | `String`                          | **Required**. Your Papercups account token.                                                                                       | N/A                  |
| **`baseUrl`**             | `String`                          | The base URL of your API if you're self-hosting Papercups. Ensure you do not include the protocol (https) of a trailing dash (/). | `"app.papercups.io"` |
| **`customer`**            | `PapercupsCustomerMetadata`       | Identifying information for the customer, including `name`, `email`, `externalId`, and `otherMetadata` (for any custom fields).   | N/A                  |
| **`closeIcon`**           | `Widget`                          | The close button displayed in the header section.                                                                                 | N/A                  |
| **`closeAction`**         | `VoidCallback`                    | The function to handle closing the widget. If not null, close button will be shown.                                               | N/A                  |
| **`scrollEnabled`**       | `bool`                            | Whether or not to allow scrolling.                                                                                                | `true`               |
| **`floatingSendMessage`** | `bool`                            | Wether to have the message box floating.                                                                                          | `false`              |
| **`requireEmailUpfront`** | `bool`                            | If you want to require unidentified customers to provide their email before they can message you. Not recommended for apps.       | `false`              |
| **`sendIcon`**            | `Widget`                          | Message send icon in the chat text field.                                                                                         | N/A                  |
| **`onMessageBubbleTap`**  | `void Function(PapercupsMessage)` | Function to handle message bubble tap action.                                                                                     | N/A                  |
| **`style`**               | `PapercupsStyle`                  | Class used to customize the widget appearance.                                                                                    | `PapercupsStyle()`   |
| **`translations`**        | `PapercupsIntl`                   | If you want to override the default `EN` translations displayed by the widget.                                                    | `PapercupsIntl()`    |

### Available `PapercupsCustomerMetadata` parameters
| Parameters          | Type                   | Value                                                     | Default |
| :------------------ | :--------------------- | :-------------------------------------------------------- | :------ |
| **`email`**         | `String`               | The customer's email                                      | N/A     |
| **`externalId`**    | `String`               | The customer's external ID                                | N/A     |
| **`name`**          | `String`               | The customer's name                                       | N/A     |
| **`otherMetadata`** | `Map<String, dynamic>` | Extra metadata to pass such as OS info, app version, etc. | N/A     |

### Available `PapercupsStyle` parameters
<table>
    <tr>
        <td>Parameters</td>
        <td>Type</td>
        <td>Value</td>
        <td>Default</td>
    </tr>
    <tr>
        <td><b><code>primaryColor</code></b></td>
        <td><code>Color</code></td>
        <td>The theme color of the chat widget.</td>
        <td>Papercups blue:<pre lang="dart">Color(0xFF1890FF)</pre></td>
    </tr>
    <tr>
        <td><b><code>primaryGradient</code></b></td>
        <td><code>Gradient</code></td>
        <td>Gradient to specify, should be used instead of <code>primaryColor</code>. <b>DO NOT USE BOTH!</b></td>
        <td>N/A</td>
    </tr>
    <tr>
        <td><b><code>backgroundColor</code></b></td>
        <td><code>Color</code></td>
        <td>Color used in the background of the entire widget.</td>
        <td><pre lang="dart">Theme.of(context).canvasColor</pre></td>
    </tr>
    <tr>
        <td><b><code>titleStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the title at the top of the chat widget.</td>
        <td><pre lang="dart">TextStyle(
  color: textColor, // Using computeLuminance
  fontSize: 21,
  fontWeight: FontWeight.w600,
)</pre></td>
    </tr>
    <tr>
        <td><b><code>titleAlign</code></b></td>
        <td><code>TextAlign</code></td>
        <td>The widget title alignment.</td>
        <td><pre lang="dart">TextAlign.left</pre></td>
    </tr>
    <tr>
        <td><b><code>subtitleStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The chat widget sub title text style.</td>
        <td><pre lang="dart">TextStyle(
  color: props.style.titleStyle?.color?.withOpacity(0.8),
)</pre></td>
    </tr>
    <tr>
        <td><b><code>headerHeight</code></b></td>
        <td><code>double</code></td>
        <td>The chat widget header height.</td>
        <td>N/A</td>
    </tr>
    <tr>
        <td><b><code>headerPadding</code></b></td>
        <td><code>EdgeInsetsGeometry</code></td>
        <td>The chat widget header padding.</td>
        <td><pre lang="dart">EdgeInsets.only(
  top: 16,
  right: 20,
  left: 20,
  bottom: 12,
)</pre></td>
    </tr>
    <tr>
        <td><b><code>noConnectionIcon</code></b></td>
        <td><code>Widget</code></td>
        <td>The widget displayed in the chat when there's no Internet connection.</td>
        <td><pre lang="dart">Icon(
  Icons.wifi_off_rounded,
  size: 100,
  color: Colors.grey,
)</pre></td>
    </tr>
    <tr>
        <td><b><code>noConnectionTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the text displayed in the chat widget when there's no Internet connection.</td>
        <td><pre lang="dart">Theme.of(context).textTheme.headline5?.copyWith(color: code.grey)</pre></td>
    </tr>
    <tr>
        <td><b><code>requireEmailUpfrontInputDecoration</code></b></td>
        <td><code>InputDecoration</code></td>
        <td>The input decoration of the require email text field.</td>
        <td><pre lang="dart">InputDecoration(
  border: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).dividerColor,
      width: 0.5,
      style: BorderStyle.solid,
    ),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).dividerColor,
      width: 0.5,
      style: BorderStyle.solid,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).dividerColor,
      width: 0.5,
      style: BorderStyle.solid,
    ),
  ),
  hintText: widget.props.translations.enterEmailPlaceholder,
  hintStyle: widget.props.style.requireEmailUpfrontInputHintStyle,
),</pre></td>
    </tr>
    <tr>
        <td><b><code>requireEmailUpfrontKeyboardAppearance</code></b></td>
        <td><code>Brightness</code></td>
        <td>The keyboard brightness of the require email text field.</td>
        <td><pre lang="dart">Brightness.light</pre></td>
    </tr>
    <tr>
        <td><b><code>requireEmailUpfrontInputHintStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the require email text field hint.</td>
        <td><pre lang="dart">TextStyle(fontSize: 14)</pre></td>
    </tr>
    <tr>
        <td><b><code>requireEmailUpfrontInputTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the require email text field.</td>
        <td>N/A</td>
    </tr>
    <tr>
        <td><b><code>floatingSendMessageBoxDecoration</code></b></td>
        <td><code>BoxDecoration</code></td>
        <td>The box decoration of the message text field when <code>floatingSendMessage</code> prop is <code>true</code>.</td>
        <td><pre lang="dart">BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      blurRadius: 10,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.withOpacity(0.4)
          : Colors.black.withOpacity(0.8),
    ),
  ],
)<pre></td>
    </tr>
    <tr>
        <td><b><code>sendMessageBoxDecoration</code></b></td>
        <td><code>BoxDecoration</code></td>
        <td>The box decoration of the message text field.</td>
        <td><pre lang="dart">BoxDecoration(
  color: Theme.of(context).cardColor,
  border: widget.showDivider
      ? Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        )
      : null,
  boxShadow: [
    BoxShadow(
      blurRadius: 30,
      color: Theme.of(context).shadowColor.withOpacity(0.1),
    )
  ],
)</pre></td>
    </tr>
    <tr>
        <td><b><code>sendMessageKeyboardAppearance</code></b></td>
        <td><code>Brightness</code></td>
        <td>The keyboard brightness of the send message text field.</td>
        <td><pre lang="dart">Brightness.light</pre></td>
    </tr>
    <tr>
        <td><b><code>sendMessagePlaceholderInputDecoration</code></b></td>
        <td><code>InputDecoration</code></td>
        <td>The input decoration of the message text field.</td>
        <td><pre lang="dart">InputDecoration(
  border: InputBorder.none,
  hintText: widget.props.translations.newMessagePlaceholder,
  hintStyle: widget.props.style.sendMessagePlaceholderTextStyle,
)</pre></td>
    </tr>
    <tr>
        <td><b><code>sendMessagePlaceholderTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the message text field input hint text.</td>
        <td><pre lang="dart">TextStyle(fontSize: 14)</pre></td>
    </tr>
    <tr>
        <td><b><code>sendMessageInputTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the message text field input.</td>
        <td>N/A</td>
    </tr>
    <tr>
        <td><b><code>botBubbleBoxDecoration</code></b></td>
        <td><code>BoxDecoration</code></td>
        <td>The box decoration of the bot chat bubbles.</td>
        <td><pre lang="dart">BoxDecoration(
  color: Theme.of(context).brightness == Brightness.light
    ? brighten(Theme.of(context).disabledColor, 80)
    : const Color(0xff282828,
  ),
  borderRadius: BorderRadius.circular(4),
  )</pre></td>
    </tr>
    <tr>
        <td><b><code>botBubbleTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the bot chat bubbles.</td>
        <td><pre lang="dart">TextStyle(
  color: Theme.of(context).textTheme.bodyText1?.color,
)</pre></td>
    </tr>
    <tr>
        <td><b><code>botAttachmentBoxDecoration</code></b></td>
        <td><code>BoxDecoration</code></td>
        <td>The box decoration of the bot attachment (images, files) chat bubbles.</td>
        <td><pre lang="dart">BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Theme.of(context).brightness == Brightness.light
    ? brighten(Theme.of(context).disabledColor, 70)
    : Color(0xff282828,
  ),
)</pre></td>
    </tr>
    <tr>
        <td><b><code>botAttachmentTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the bot attachments file name.</td>
        <td><pre lang="dart">TextStyle(
  color: Theme.of(context).textTheme.bodyText1?.color,
)</pre></td>
    </tr>
     <tr>
        <td><b><code>botBubbleUsernameTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of bot user name displayed below its chat bubbles.</td>
        <td><pre lang="dart">TextStyle(
  color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.5),
  fontSize: 14,
)</pre></td>
    </tr>
        <tr>
        <td><b><code>userBubbleBoxDecoration</code></b></td>
        <td><code>BoxDecoration</code></td>
        <td>The box decoration of the user chat bubbles.</td>
        <td><pre lang="dart">BoxDecoration(
  color: widget.props.style.primaryColor,
  gradient: widget.props.style.primaryGradient,
  borderRadius: BorderRadius.circular(4),
)</pre></td>
    </tr>
    <tr>
        <td><b><code>userBubbleTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the user chat bubbles.</td>
        <td><pre lang="dart">TextStyle(color: widget.textColor)</pre><i>Depending on the luminance of the provided <code>primaryColor</code>, <code>textColor</code> can be either <code>Colors.black</code> or <code>Colors.white</code>.</i></td>
    </tr>
    <tr>
        <td><b><code>userAttachmentBoxDecoration</code></b></td>
        <td><code>BoxDecoration</code></td>
        <td>The box decoration of the user attachment (images, files) chat bubbles.</td>
        <td><pre lang="dart">BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: darken(widget.props.style.primaryColor!, 20),
)</pre></td>
    </tr>
    <tr>
        <td><b><code>userAttachmentTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the user attachments file name.</td>
        <td><pre lang="dart">TextStyle(color: widget.textColor)</pre><i>Depending on the luminance of the provided <code>primaryColor</code>, <code>textColor</code> can be either <code>Colors.black</code> or <code>Colors.white</code>.</i></td>
    </tr>
    <tr>
        <td><b><code>userBubbleSentAtTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the <i>"Sent x ago"</i> (or <i>"Sending..."</i>) text displayed below the latest user chat bubble.</td>
        <td><pre lang="dart">TextStyle(color: Colors.grey)</pre></td>
    </tr>
    <tr>
        <td><b><code>chatBubbleTimeTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the time stamp displayed (on tap) next to the any chat bubble.</td>
        <td><pre lang="dart">TextStyle(
  color: Theme.of(context).textTheme.bodyText1?.color?.withAlpha(100),
  fontSize: 10,
)</pre></td>
    </tr>
    <tr>
        <td><b><code>chatBubbleFullDateTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the date displayed centered in the chat before the chat bubbles of a given day.</td>
        <td><pre lang="dart">TextStyle(color: Colors.grey)</pre></td>
    </tr>
    <tr>
        <td><b><code>chatUploadingAlertTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the alert shown when an attachment is being uploaded.</td>
        <td><pre lang="dart">Theme.of(context).textTheme.bodyText2</pre></td>
    </tr>
    <tr>
        <td><b><code>chatUploadingAlertBackgroundColor</code></b></td>
        <td><code>Color</code></td>
        <td>The background color of the alert shown when an attachment is being uploaded.</td>
        <td><pre lang="dart">Theme.of(context).bottomAppBarColor</pre></td>
    </tr>
    <tr>
        <td><b><code>chatUploadErrorAlertTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the error alert shown when an attachment failed to upload.</td>
        <td><pre lang="dart">Theme.of(context).textTheme.bodyText2</pre></td>
    </tr>
    <tr>
        <td><b><code>chatUploadErrorAlertBackgroundColor</code></b></td>
        <td><code>Color</code></td>
        <td>The background color of the error alert shown when an attachment failed to upload.</td>
        <td><pre lang="dart">Theme.of(context).bottomAppBarColor</pre></td>
    </tr>
    <tr>
        <td><b><code>chatNoConnectionAlertTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the alert shown when the chat is displayed but no Internet connection is available.</td>
        <td><pre lang="dart">Theme.of(context).textTheme.bodyText2</pre></td>
    </tr>
    <tr>
        <td><b><code>chatNoConnectionAlertBackgroundColor</code></b></td>
        <td><code>Color</code></td>
        <td>The background color of the alert shown when the chat is displayed but no Internet connection is available.</td>
        <td><pre lang="dart">Theme.of(context).bottomAppBarColor</pre></td>
    </tr>
    <tr>
        <td><b><code>chatCopiedTextAlertTextStyle</code></b></td>
        <td><code>TextStyle</code></td>
        <td>The text style of the alert shown when a chat bubble gets long pressed and its text copied.</td>
        <td><pre lang="dart">Theme.of(context).textTheme.bodyText2</pre></td>
    </tr>
    <tr>
        <td><b><code>chatCopiedTextAlertBackgroundColor</code></b></td>
        <td><code>Color</code></td>
        <td>The background color of the alert shown when a chat bubble gets long pressed and its text copied.</td>
        <td><pre lang="dart">Theme.of(context).bottomAppBarColor</pre></td>
    </tr>
</table>

### Available `PapercupsIntl` parameters
| Parameters                      | Type     | Value                                                                        | Default                                                           |
| :------------------------------ | :------- | :--------------------------------------------------------------------------- | :---------------------------------------------------------------- |
| **`attachmentNamePlaceholder`** | `String` | Text displayed when an attachment doesn't have a file name                   | `"No Name"`                                                       |
| **`attachmentUploadErrorText`** | `String` | Error message displayed when an attachment could not be uploaded             | `"Failed to upload attachment"`                                   |
| **`attachmentUploadedText`**    | `String` | Text displayed when an attachment has been uploaded                          | `"Attachment uploaded"`                                           |
| **`attachmentUploadingText`**   | `String` | Text displayed when an attachment is been uploaded                           | `"Uploading..."`                                                  |
| **`companyName`**               | `String` | Company name to show on greeting                                             | `"Bot"`                                                           |
| **`enterEmailPlaceholder`**     | `String` | This is the placeholder text in the email input section                      | `"Enter your email"`                                              |
| **`fileText`**                  | `String` | Text displayed on the tile where the user decides to upload a file           | `"File"`                                                          |
| **`greeting`**                  | `String` | An optional initial message to greet your customers with                     | N/A                                                               |
| **`historyFetchErrorText`**     | `String` | Error message displayed when the customer history couldn't be fetched        | `"There was an issue retrieving your details. Please try again!"` |
| **`imageText`**                 | `String` | Text displayed on the tile where the user decides to upload an image         | `"Image"`                                                         |
| **`loadingText`**               | `String` | Text displayed when the chat is loading                                      | `"Loading..."`                                                    |
| **`newMessagePlaceholder`**     | `String` | The placeholder text in the new message input                                | `"Start typing..."`                                               |
| **`noConnectionText`**          | `String` | The placeholder text in the new message input                                | `"No Connection"`                                                 |
| **`retryButtonLabel`**          | `String` | Label used in the retry button when the chat history couldn't be fetched     | `"Retry"`                                                         |
| **`sendingText`**               | `String` | Text to show while message is sending                                        | `"Sending..."`                                                    |
| **`sentText`**                  | `String` | Text to show when the message is sent                                        | `"Sent"`                                                          |
| **`subtitle`**                  | `String` | The subtitle in the header of your chat widget                               | `"How can we help you?"`                                          |
| **`textCopiedText`**            | `String` | Text displayed when a text has been copied after long press on a chat bubble | `"Text copied to clipboard"`                                      |
| **`title`**                     | `String` | The title in the header of your chat widget                                  | `"Welcome!"`                                                      |
| **`uploadedText`**              | `String` | Text displayed after the percentage value of an attachment being uploaded    | `"uploaded"`                                                      |


## Supporters
[![Stargazers repo roster for @papercups-io/papercups_flutter](https://reporoster.com/stars/papercups-io/papercups_flutter)](https://github.com/papercups-io/papercups_flutter/stargazers) [![Forkers repo roster for @papercups-io/papercups_flutter](https://reporoster.com/forks/papercups-io/papercups_flutter)](https://github.com/papercups-io/papercups_flutter/network/members)
