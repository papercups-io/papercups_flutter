library papercups_flutter;

// Imports.
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:papercups_flutter/agentAvaiability.dart';
import 'package:papercups_flutter/chat.dart';

import 'classes.dart';
import 'sendMessage.dart';
import 'header.dart';

// Exports.
export 'classes.dart';

/// Returns the webview which contains the chat. To use it simply call PaperCupsWidget(), making sure to add the props!
class PaperCupsWidget extends StatelessWidget {
  /// Initialize the props that you will pass on PaperCupsWidget.
  final Props props;

  ///Function to run when the close button is clicked. Not supported on web!
  final Function closeAction;

  /// Will be invoked once the view is created, and the page starts to load.
  final Function onStartLoading;

  /// Will be invoked once the page is loaded.
  final Function onFinishLoading;

  /// Will be called if there is some sort of issue loading the page, for example if there are images missing. Should not be invoked normally.
  final Function onError;

  PaperCupsWidget({
    this.closeAction,
    this.onError,
    this.onFinishLoading,
    this.onStartLoading,
    @required this.props,
  });

  @override
  Widget build(BuildContext context) {
    if (props.primaryColor == null) {
      props.primaryColor = Theme.of(context).primaryColor;
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Header(props: props),
          if (props.showAgentAvailability) AgentAvailability(props),
          Expanded(
            child: ChatMessages(props),
          ),
          SendMessage(props: props),
        ],
      ),
    );
  }
}
