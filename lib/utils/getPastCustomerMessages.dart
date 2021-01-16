//Imports
import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

/// This function is used to get the past messages from the customer.
Future<Map<String, dynamic>> getPastCustomerMessages(
  Props p,
  PapercupsCustomer c, {
  Client client,
}) async {
  if (client == null) {
    client = Client();
  }
  List<PapercupsMessage> rMsgs = [];

  try {
    // Get messages.
    var res = await client.get(
      Uri.https(p.baseUrl, "/api/conversations/customer", {
        "customer_id": c.id,
        "account_id": p.accountId,
      }),
      headers: {"Accept": "*/*"},
    );

    // JSON Decode.
    var data = jsonDecode(res.body)["data"][0];

    // For every message generate a PapercupsMessage object and add it to the list.
    data["messages"].forEach((val) {
      rMsgs.add(
        PapercupsMessage(
          accountId: val["account_id"],
          body: val["body"],
          createdAt: DateTime.tryParse(val["created_at"]),
          sentAt: DateTime.tryParse(val["sent_at"]),
          conversationId: val["conversation_id"],
          customerId: val["customer_id"],
          customer: c,
          id: val["id"],
          userId: val["user_id"],
          user: val["user"] != null
              ? User(
                  email: val["user"]["email"],
                  id: val["user"]["id"],
                  role: val["user"]["role"],
                  fullName: (val["user"]["full_name"] != null)
                      ? val["user"]["full_name"]
                      : null,
                  profilePhotoUrl: (val["user"]["profile_photo_url"] != null)
                      ? val["user"]["profile_photo_url"]
                      : null,
                )
              : null,
        ),
      );
    });
    // Get the customer details.
    var customerData = data["customer"];
    c = PapercupsCustomer(
      createdAt: DateTime.tryParse(customerData["created_at"]),
      email: customerData["email"],
      externalId: customerData["external_id"],
      firstSeen: DateTime.tryParse(customerData["first_seen"]),
      id: customerData["id"],
      lastSeen: DateTime.tryParse(customerData["last_seen"]),
      updatedAt: DateTime.tryParse(customerData["updated_at"]),
      name: customerData["name"],
      phone: customerData["phone"],
    );
  } catch (e) {
    print("An error ocurred while getting past customer data.");
  }
  client.close();
  // Return messages and customer details.
  return {
    "msgs": rMsgs,
    "cust": c,
  };
}
