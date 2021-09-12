import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';
import 'utils.dart';

Future<PapercupsCustomer> getCustomerDetails(
  Props p,
  PapercupsCustomer? c,
  Function? sc, {
  Client? client,
}) async {
  if (c?.id != null) {
    return Future.value(c);
  }
  if (client == null) {
    client = Client();
  }
  try {
    var timeNow = DateTime.now().toUtc().toIso8601String();
    var metadata = p.customer != null && p.customer!.otherMetadata != null
        ? p.customer!.otherMetadata!
        : {};
    var jsonString = jsonEncode(
      {
        "customer": {
          "account_id": p.accountId,
          "name": c != null ? c.name : null,
          "email": c != null ? c.email : null,
          "external_id": c != null ? c.externalId : null,
          "first_seen": timeNow,
          "last_seen_at": timeNow,
          ...metadata,
        }
      },
    );
    var res = await client.post(
      Uri.parse("https://" + p.baseUrl + "/api/customers"),
      headers: {
        "content-type": "application/json",
      },
      body: jsonString,
    );
    var data = jsonDecode(res.body)["data"];
    c = PapercupsCustomer(
      createdAt: data["created_at"] != null
          ? parseDateFromUTC(data["created_at"])
          : null,
      email: data["email"],
      externalId: data["external_id"],
      firstSeen: data["first_seen"] != null
          ? parseDateFromUTC(data["first_seen"])
          : null,
      id: data["id"],
      lastSeenAt: data["last_seen_at"] != null
          ? parseDateFromUTC(data["last_seen_at"])
          : null,
      updatedAt: data["updated_at"] != null
          ? parseDateFromUTC(data["updated_at"])
          : null,
      name: data["name"],
      phone: data["phone"],
    );
  } catch (e) {
    throw (e);
  }
  client.close();
  return c;
}
