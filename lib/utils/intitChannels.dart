import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/papercups_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import '../models/message.dart';

initChannels(
  bool _connected,
  PhoenixSocket _socket,
  PhoenixChannel _conversation,
  PhoenixChannel _channel,
  Props props,
  List<PapercupsMessage> messages,
  Function setState,
) {
  print("Initializing channels...");
  var debugConvId = "5220ce7b-6fae-495b-b10a-afb7b84dfbe6";
  if (_connected & _socket.channels.isEmpty) {
    _channel = _socket.addChannel(
      topic: 'room:' + props.accountId,
    );
    _channel.join().onReply(
      "ok",
      (res) {
        if (res.isOk) {
          _conversation =
              _socket.addChannel(topic: "conversation:" + debugConvId);
          _conversation.join();
          _conversation.messages.listen(
            (event) {
              if (event.payload != null) {
                if (event.payload["status"] == "error") {
                  _conversation.close();
                  _socket.removeChannel(_conversation);
                  _conversation == null;
                } else if (event.payload["status"] == "ok") {
                  print("All Ok");
                } else {
                  if (event.event.toString() == "PhoenixChannelEvent(shout)") {
                    setState(
                      () {
                        messages.add(
                          PapercupsMessage(
                            accountId: event.payload["account_id"],
                            body: event.payload["body"].toString().trim(),
                            conversationId: event.payload["conversation_id"],
                            customerId: event.payload["customer_id"],
                            id: event.payload["id"],
                            user: User(
                              email: event.payload["user"]["email"],
                              id: event.payload["user"]["id"],
                              role: event.payload["user"]["role"],
                              fullName:
                                  (event.payload["user"]["full_name"] != null)
                                      ? event.payload["user"]["full_name"]
                                      : null,
                              profilePhotoUrl: (event.payload["user"]
                                          ["profile_photo_url"] !=
                                      null)
                                  ? event.payload["user"]["profile_photo_url"]
                                  : null,
                            ),
                            userId: event.payload["user_id"],
                          ),
                        );
                      },
                    );
                  }
                }
              }
            },
          );
        }
      },
    );
  }
}
