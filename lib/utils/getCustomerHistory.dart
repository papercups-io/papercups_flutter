import 'package:papercups_flutter/utils/updateUserMetadata.dart';

import '../models/models.dart';
import '../papercups_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'dart:async';

import 'getCustomerDetailsFromMetadata.dart';
import 'getPastCustomerMessages.dart';
import 'joinConversation.dart';

Future<bool> getCustomerHistory({
  PaperCupsWidget widget,
  PapercupsCustomer c,
  Function setCustomer,
  List<PapercupsMessage> messages,
  PhoenixChannel conversationChannel,
  Function setConversationChannel,
  Function rebuild,
  PhoenixSocket socket,
}) async {
  var customer = await getCustomerDetailsFromMetadata(
    widget.props,
    c,
    setCustomer,
  );
  if (customer != null && customer.id != null) {
    var data = await getPastCustomerMessages(widget.props, customer);
    if (data["msgs"].isNotEmpty) {
      {
        var msgsIn = data["msgs"] as List<PapercupsMessage>;
        msgsIn.sort((a, b) {
          return a.createdAt.compareTo(b.createdAt);
        });
        messages.addAll(msgsIn);
      }
      var msgToProcess = data["msgs"][0] as PapercupsMessage;
      joinConversationAndListen(
        convId: msgToProcess.conversationId,
        conversation: conversationChannel,
        setChannel: setConversationChannel,
        setState: rebuild,
        socket: socket,
        messages: messages,
      );
    }
    if (data["cust"] != null && data["cust"] != customer) {
      updateUserMetadata(widget.props, data["cust"].id).then((customer) {
        setCustomer(customer);
      });
      rebuild(() {}, animate: true);
      return true;
    }
  }
  return false;
}
