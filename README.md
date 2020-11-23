![logo](https://i.imgur.com/QHer84L.png)
[![pub package](https://img.shields.io/pub/v/papercups_flutter.svg?label=papercups_flutter&color=blue)](https://pub.dev/packages/papercups_flutter) [![likes](https://badges.bar/papercups_flutter/likes)](https://pub.dev/packages/papercups_flutter/score)  [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart)
## Installing
To get started simply add `papercups_flutter:` and the latest version to your pubspec.yaml.
Then run `flutter pub get`

🎉 Done, It's that simple.
## Using the widget
Integration with your app requires just a few lines of code, add the following widget wherever you want your papercups chat window to be:

    PaperCupsWidget(
	    props: Props(
	    accountId: "xxxxxxxx-xxxxxxx-xxxx-xxxxxx", //Your account id goes here.
	    ),
    ),
That should get you up and running in just a few seconds ⚡️.

## Configuration

### Available PaperCupsWidget arguments
| Parameter | Type | Value | Default |
| :--- | :--- | :----- | :------ |
| **`iframeUrl`** | `string` | An override of the iframe URL we use to render the chat, if you chose to self-host that as well | https://chat-widget.papercups.io |
| **`props`** | `Props` | **Required**, here is where all of the config for the chat is contained| N/A |
| **`closeAction`** | `Function` | A function to execute on the close button, only visible in mobile versions. If `null`, close button will not render.| N/A |

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

## Known Issues

 - closeAction is not supported on Web at this point in time, this is due to the iframe absorbing all clicks before the button detected them. For more info see https://github.com/flutter/flutter/issues/54027.
 - Some widgets such as `clipRRect` will not affect the WebView on mobile, and will not change the widget. This works on web though.