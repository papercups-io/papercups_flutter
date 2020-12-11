import 'dart:convert';

import 'package:http/http.dart';
import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/models/customer.dart';

Future<PapercupsCustomer> getCustomerDetails(
  Props p,
  PapercupsCustomer c,
  Function sc,
) async {
  var res = await post(
    "https://" + p.baseUrl + "/api/customers",
    headers: {
      "content-type": "application/json",
    },
    body: jsonEncode(
      {
        "customer": {
          "account_id": p.accountId,
          "first_seen": DateTime.now().toUtc().toIso8601String(),
          "last_seen": DateTime.now().toUtc().toIso8601String(),
        },
      },
    ),
  );
  var data = jsonDecode(res.body)["data"];
  c = PapercupsCustomer(
    createdAt: DateTime.tryParse(data["created_at"]),
    email: data["email"],
    id: data["id"],
  );
  return c;
}
