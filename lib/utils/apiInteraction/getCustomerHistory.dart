//Imports
import 'updateUserMetadata.dart';

import '../../models/models.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'dart:async';

import 'getCustomerDetailsFromMetadata.dart';
import 'getPastCustomerMessages.dart';
import '../socket/joinConversation.dart';

/// This function is used to get the history.
/// It also initializes the necessary funtions if the customer is known.
Future<bool> getCustomerHistory({
  required Props props,
  PapercupsCustomer? c,
  required Function setCustomer,
  List<PapercupsMessage>? messages,
  PhoenixChannel? conversationChannel,
  Function? setConversationChannel,
  Function? rebuild,
  PhoenixSocket? socket,
}) async {
  var failed = true;
  try {
    // Get customer details.
    var customer = await getCustomerDetailsFromMetadata(
      props,
      c,
      setCustomer,
    );
    failed = false;
    if (customer.id != null) {
      // If customer is not null and there is an ID get the past messages.
      var data = await getPastCustomerMessages(props, customer);
      if (data["msgs"] != null) failed = false;
      if (data["msgs"].isNotEmpty) {
        {
          // If there are messages to load sort them by date.
          var msgsIn = data["msgs"] as List<PapercupsMessage>;
          msgsIn.sort((a, b) {
            return a.createdAt!.compareTo(b.createdAt!);
          });
          // Add them to the message list.
          messages!.addAll(msgsIn);
        }
        // Get the first message (as we know there is at leat one messgae)
        // We use this to get the details we need to join a conversation.
        var msgToProcess = data["msgs"][0] as PapercupsMessage;
        joinConversationAndListen(
          convId: msgToProcess.conversationId!,
          conversation: conversationChannel,
          setChannel: setConversationChannel!,
          setState: rebuild,
          socket: socket!,
          messages: messages,
        );
      }
      if (data["cust"] != null && data["cust"] != customer) {
        // Determine if we need to update the customer details.
        var nCust = await updateUserMetadata(props, data["cust"].id);
        if (nCust == null) {
          // Will only return null if the update failed.
          failed = true;
        } else if (nCust != customer) {
          // If the new customer is different then we update the details we have.
          setCustomer(nCust);
          rebuild!(() {}, animate: true);
        }
      }
    }
  } catch (e) {
    failed = true;
  }
  return failed;
}
