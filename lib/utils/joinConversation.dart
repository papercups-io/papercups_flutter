import 'package:flutter/foundation.dart';
import '../models/models.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import '../models/message.dart';

PhoenixChannel joinConversationAndListen({
  List<PapercupsMessage> messages,
  @required String convId,
  @required PhoenixChannel conversation,
  @required PhoenixSocket socket,
  @required Function setState,
  @required Function setChannel,
}) {
  conversation = socket.addChannel(topic: "conversation:" + convId);
  conversation.join();
  setChannel(conversation);
  conversation.messages.listen(
    (event) {
      if (event.payload != null) {
        if (event.payload["status"] == "error") {
          conversation.close();
          socket.removeChannel(conversation);
          conversation == null;
        } else {
          if (event.event.toString().contains("shout")) {
            setState(
              () {
                if (event.payload["customer"] == null)
                  messages.add(
                    PapercupsMessage(
                      accountId: event.payload["account_id"],
                      body: event.payload["body"].toString().trim(),
                      conversationId: event.payload["conversation_id"],
                      customerId: event.payload["customer_id"],
                      id: event.payload["id"],
                      user: (event.payload["user"] != null)
                          ? User(
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
                            )
                          : null,
                      customer: (event.payload["customer"] != null)
                          ? PapercupsCustomer(
                              email: event.payload["customer"]["email"],
                              id: event.payload["customer"]["id"],
                            )
                          : null,
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
  return conversation;
}
