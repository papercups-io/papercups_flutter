![logo](https://i.imgur.com/QHer84L.png)
[![pub package](https://img.shields.io/pub/v/papercups_flutter.svg?label=papercups_flutter&color=blue)](https://pub.dev/packages/papercups_flutter) [![likes](https://badges.bar/papercups_flutter/likes)](https://pub.dev/packages/papercups_flutter/score)  [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart)

# ⚠️⚠️⚠️ This branch is under active development. Do not use in production, to view the stable branch take a look at [main](https://github.com/papercups-io/papercups_flutter/tree/main/)⚠️⚠️⚠️


## Main repository
https://github.com/papercups-io/papercups

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

### Available PaperCupsWidget arguments
| Parameter | Type | Value | Default |
| :--- | :--- | :----- | :------ |
| **`iframeUrl`** | `string` | An override of the iframe URL we use to render the chat, if you chose to self-host that as well | https://chat-widget.papercups.io |
| **`props`** | `Props` | **Required**, here is where all of the config for the chat is contained| N/A |
| **`closeAction`** | `Function` | A function to execute on the close button, only visible in mobile versions. If `null`, close button will not render.| N/A |
| **`onStartLoading`** | `Function` | A function that will be called when the widget starts loading the website.| N/A |
| **`onFinishLoading`** | `Function` | A function that will be called when the widget finishes loading the website. **May be called multiple times**| N/A |
| **`onError`** | `Function` | A function that will be called if the widget finds an error while loading. | N/A |


### Available Props paramaters
| Prop | Type | Value | Default |
| :--- | :--- | :----- | :------ |
| **`accountId`** | `string` | **Required**, your Papercups account token | N/A |
| **`title`** | `string` | The title in the header of your chat widget | Welcome! |
| **`subtitle`** | `string` | The subtitle in the header of your chat widget | How can we help you? |
| **`newMessagePlaceholder`** | `string` | The placeholder text in the new message input | Start typing... |
| **`primaryColor`** | `Color` | The theme color of your chat widget | `Theme.of(context).primaryColor` without alpha |
| **`greeting`** | `string` | An optional initial message to greet your customers with | N/A |
| **`showAgentAvailability`** | `boolean` | If you want to show whether you (or your agents) are online or not | `false` |
| **`agentAvailableText`** | `string` | The text shown when you (or your agents) are online | We're online right now! |
| **`agentUnavailableText`** | `string` | The text shown when you (and your agents) are offline | We're away at the moment. |
| **`customer`** | `CustomerMetadata` | Identifying information for the customer, including `name`, `email`, `external_id`, and `metadata` (for any custom fields) | N/A |
| **`baseUrl`** | `string` | The base URL of your API if you're self-hosting Papercups | https://app.papercups.io |
| **`requireEmailUpfront`** | `boolean` | If you want to require unidentified customers to provide their email before they can message you | `false` |

### Available CustomerMetaData paramaters
| Parameters | Type | Value | Default |
| :--- | :--- | :----- | :------ |
| **`email`** | `string` | The customer's email| N/A |
| **`externalId`** | `string` | The customer's external ID | N/A |
| **`name`** | `string` | The customer's name | N/A |
| **`otherMetadata`** | `Map<String, String>` | Extra metadata to pass such as OS info. | N/A |
