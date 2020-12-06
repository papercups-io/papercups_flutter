import 'dart:convert';

import 'package:http/http.dart';
import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/models/customer.dart';

void getCustomerDetails(
  Props p,
  PapercupsCustomer c,
  Function sc,
) {
  post(
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
  ).then(
    (res) {
      var data = jsonDecode(res.body);
      c = PapercupsCustomer(
        createdAt: data["created_at"],
        email: data["email"],
        id: data["id"],
      );
      sc(c);
    },
  );
}
