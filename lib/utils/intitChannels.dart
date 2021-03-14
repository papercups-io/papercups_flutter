// Imports
import '../models/models.dart';
import '../papercups_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

/// This function creates the necessary channels, sockets and rooms for papercups to communicate.
initChannels(
  bool _connected,
  PhoenixSocket _socket,
  PhoenixChannel? _channel,
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
          _canJoinConversation = true;
        }
      },
    );
  }
}
