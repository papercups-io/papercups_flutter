import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

Future<PapercupsCustomer> getCustomerDetails(
  Props p,
  PapercupsCustomer c,
  Function sc, {
  Client client,
}) async {
  if (client == null) {
    client = Client();
  }
  var timeNow = DateTime.now().toIso8601String();
  var metadata = p.customer != null && p.customer.otherMetadata != null
      ? p.customer.otherMetadata
      : {};
  var jsonString = jsonEncode(
    {
      "customer": {
        "account_id": p.accountId,
        "name": c != null ? c.name : null,
        "email": c != null ? c.email : null,
        "external_id": c != null ? c.externalId : null,
        "first_seen": timeNow,
        "last_seen": timeNow,
        ...metadata,
      }
    },
  );
  var res = await client.post(
    "https://" + p.baseUrl + "/api/customers",
    headers: {
      "content-type": "application/json",
    },
    body: jsonString,
  );
  var data = jsonDecode(res.body)["data"];
  c = PapercupsCustomer(
    createdAt: data["created_at"] != null
        ? DateTime.tryParse(data["created_at"])
        : null,
    email: data["email"],
    externalId: data["external_id"],
    firstSeen: data["first_seen"] != null
        ? DateTime.tryParse(data["first_seen"])
        : null,
    id: data["id"],
    lastSeen:
        data["last_seen"] != null ? DateTime.tryParse(data["last_seen"]) : null,
    updatedAt: data["updated_at"] != null
        ? DateTime.tryParse(data["updated_at"])
        : null,
    name: data["name"],
    phone: data["phone"],
  );
  client.close();
  return c;
}
