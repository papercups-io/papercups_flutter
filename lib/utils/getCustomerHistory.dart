import 'updateUserMetadata.dart';

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
  var failed = true;
  try {
    var customer = await getCustomerDetailsFromMetadata(
      widget.props,
      c,
      setCustomer,
    );
    if (customer != null) failed = false;
    if (customer != null && customer.id != null) {
      var data = await getPastCustomerMessages(widget.props, customer);
      if (data["msgs"] != null) failed = false;
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
        var nCust = await updateUserMetadata(widget.props, data["cust"].id);
        if (nCust == null) {
          failed = true;
        } else if (nCust != customer) {
          setCustomer(nCust);
          rebuild(() {}, animate: true);
        }
      }
    }
  } catch (e) {
    failed = true;
  }
  return failed;
}
