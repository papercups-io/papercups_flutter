import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

Future<Conversation> getConversationDetails(
  Props p,
  Conversation conv,
  PapercupsCustomer customer,
  Function sc, {
  Client client,
}) async {
  if (client == null) {
    client = Client();
  }
  var res = await post(
    "https://" + p.baseUrl + "/api/conversations",
    headers: {
      "content-type": "application/json",
    },
    body: jsonEncode(
      {
        "conversation": {
          "account_id": p.accountId,
          "customer_id": customer.id,
        },
      },
    ),
  );
  try {
    var data = jsonDecode(res.body)["data"];
    conv = Conversation(
      id: data["id"],
      customerId: data["customer_id"],
      accountId: data["account_id"],
      asigneeId: data["asignee_id"],
      createdAt: data["created_at"],
      read: data["read"],
    );
    sc(conv);
  } catch (e) {
    conv = null;
  }
  client.close();
  return conv;
}
