import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

Future<Map<String, dynamic>> getPastCustomerMessages(
  Props p,
  PapercupsCustomer c,
) async {
  List<PapercupsMessage> rMsgs = [];
  
  var res = await get(
    Uri.https(p.baseUrl, "/api/conversations/customer", {
      "customer_id": c.id,
      "account_id": p.accountId,
    }),
    headers: {"Accept": "*/*"},
  );
  var data = jsonDecode(res.body)["data"][0];
  data["messages"].forEach((val) {
    rMsgs.add(
      PapercupsMessage(
        accountId: val["account_id"],
        body: val["body"],
        createdAt: DateTime.tryParse(val["created_at"]),
        conversationId: val["conversation_id"],
        customerId: val["customer_id"],
        customer: c,
        id: val["id"],
      ),
    );
  });
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

  return {
    "msgs": rMsgs,
    "cust": c,
  };
}
