//Imports
import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';
import 'utils.dart';

/// This function is used to get the past messages from the customer.
Future<Map<String, dynamic>> getPastCustomerMessages(
  Props p,
  PapercupsCustomer c, {
  Client? client,
}) async {
  if (client == null) {
    client = Client();
  }
  List<PapercupsMessage> rMsgs = [];
  PapercupsCustomer newCust;

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
    var data = jsonDecode(res.body)["data"];
    try {
      data = data[0];
    } catch (e) {
      return {
        "msgs": rMsgs,
        "cust": c,
      };
    }

    data[0]["messages"].forEach((val) {
      rMsgs.add(
        PapercupsMessage(
          accountId: val["account_id"],
          body: val["body"],
          createdAt: parseDateFromUTC(val["created_at"]),
          sentAt: parseDateFromUTC(val["sent_at"]),
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
    newCust = PapercupsCustomer(
      createdAt: parseDateFromUTC(customerData["created_at"]),
      email: customerData["email"],
      externalId: customerData["external_id"],
      firstSeen: parseDateFromUTC(customerData["first_seen"]),
      id: customerData["id"],
      lastSeenAt: parseDateFromUTC(customerData["last_seen_at"]),
      updatedAt: parseDateFromUTC(customerData["updated_at"]),
      name: customerData["name"],
      phone: customerData["phone"],
    );
  } catch (e) {
    print("An error ocurred while getting past customer data.");
    return {
      "msgs": [],
      "cust": c,
    };
  }
  client.close();
  // Return messages and customer details.
  return {
    "msgs": rMsgs,
    "cust": newCust,
  };
}
