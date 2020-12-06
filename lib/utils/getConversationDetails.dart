import 'dart:convert';

import 'package:http/http.dart';
import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/models/conversation.dart';
import 'package:papercups_flutter/models/customer.dart';

Future<Conversation> getConversationDetails(
  Props p,
  Conversation conv,
  PapercupsCustomer customer,
  Function sc,
) async {
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
  return conv;
}
