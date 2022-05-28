// Imports
import '../../models/models.dart';
import '../../papercups_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

/// This function creates the necessary channels, sockets and rooms for papercups to communicate.
initChannels(
  bool connected,
  PhoenixSocket socket,
  PhoenixChannel? channel,
  PapercupsProps props,
  bool canJoinConversation,
  Function setState,
) {
  if (connected & socket.channels.isEmpty) {
    channel = socket.addChannel(
      topic: 'room:${props.accountId}',
    );
    channel.join().onReply(
      "ok",
      (res) {
        if (res.isOk && !canJoinConversation) {
          canJoinConversation = true;
        }
      },
    );
  }
}
