import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

Future<PapercupsCustomer> getCustomerDetails(
  Props p,
  PapercupsCustomer c,
  Function sc,
) async {
  var timeNow = DateTime.now().toIso8601String();
  var res = await post(
    "https://" + p.baseUrl + "/api/customers",
    headers: {
      "content-type": "application/json",
    },
    body: jsonEncode(
      {
        "customer": {
          "account_id": p.accountId,
          "first_seen": timeNow,
          "last_seen": timeNow,
        },
      },
    ),
  );
  var data = jsonDecode(res.body)["data"];
  c = PapercupsCustomer(
    createdAt: DateTime.tryParse(data["created_at"]),
    email: data["email"],
    id: data["id"],
    externalId: data["external_id"],
    firstSeen: DateTime.tryParse(data["first_seen"]),
    lastSeen: DateTime.tryParse(data["last_seen"]),
    name: data["name"],
    phone: data["phone"],
    updatedAt: DateTime.tryParse(data["updated_at"]),
  );
  return c;
}
