library papercups_flutter;

// Imports.
import 'package:flutter/material.dart';
import 'package:papercups_flutter/widgets/agentAvaiability.dart';
import 'package:papercups_flutter/widgets/chat.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'models/classes.dart';
import 'widgets/sendMessage.dart';
import 'widgets/header.dart';

// Exports.
export 'models/classes.dart';

/// Returns the webview which contains the chat. To use it simply call PaperCupsWidget(), making sure to add the props!
class PaperCupsWidget extends StatefulWidget {
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
  _PaperCupsWidgetState createState() => _PaperCupsWidgetState();
}

class _PaperCupsWidgetState extends State<PaperCupsWidget> {
  bool _connected = false;
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  PhoenixChannel _conversation;
  var debugConvId = "5220ce7b-6fae-495b-b10a-afb7b84dfbe6";

  @override
  void initState() {
    if (widget.props.baseUrl.contains("http"))
      throw "Do not provide a protocol in baseURL";
    if (widget.props.baseUrl.endsWith("/")) throw "Do not provide a trailing /";
    _socket =
        PhoenixSocket("wss://" + widget.props.baseUrl + '/socket/websocket')
          ..connect();

    _socket.closeStream.listen((event) {
      setState(() => _connected = false);
    });

    _socket.openStream.listen(
      (event) {
        setState(
          () {
            _channel = _socket.addChannel(
              topic: 'room:' + widget.props.accountId,
            );
            return _connected = true;
          },
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _channel.close();
    _socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_connected && (!_channel.isJoined || !_channel.isJoining)) {
      _channel.join().onReply("ok", (res) {
        if(res.isOk){
          _conversation = _socket.addChannel(topic: "conversation:" + debugConvId);
          _conversation.join();
          _conversation.messages.listen((event) {
            if(event.payload["status"] == "error"){
              _conversation.close();
              _socket.removeChannel(_conversation);
              _conversation == null;
            }else if(event.payload["status"] == "ok"){
              print("All Ok");
            }else{
              print(event.payload["body"]);
            }
          });
        }
      });
    }
    if (widget.props.primaryColor == null) {
      widget.props.primaryColor = Theme.of(context).primaryColor;
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Header(props: widget.props),
          if (widget.props.showAgentAvailability)
            AgentAvailability(widget.props),
          Expanded(
            child: ChatMessages(widget.props),
          ),
          SendMessage(props: widget.props),
        ],
      ),
    );
  }
}
