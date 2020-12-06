import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/papercups_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import '../models/message.dart';

initChannels(
  bool _connected,
  PhoenixSocket _socket,
  PhoenixChannel _channel,
  Props props,
  bool _canJoinConversation,
  Function setState,
) {
  if (_connected & _socket.channels.isEmpty) {
    _channel = _socket.addChannel(
      topic: 'room:' + props.accountId,
    );
    _channel.join().onReply(
      "ok",
      (res) {
        if (res.isOk && !_canJoinConversation) {
          setState(() {
            _canJoinConversation = true;
          });
        }
      },
    );
  }
}
