import 'dart:convert';

import 'package:http/http.dart';
import '../../models/models.dart';
import '../utils.dart';

Future<PapercupsCustomer> getCustomerDetails(
  PapercupsProps p,
  PapercupsCustomer? c,
  Function? sc, {
  Client? client,
}) async {
  if (c?.id != null) {
    return Future.value(c);
  }
  client ??= Client();
  try {
    var timeNow = DateTime.now().toUtc().toIso8601String();
    var metadata = p.customer?.otherMetadata ?? {};
    var jsonString = jsonEncode(
      {
        "customer": {
          "account_id": p.accountId,
          "name": c?.name,
          "email": c?.email,
          "external_id": c?.externalId,
          "first_seen": timeNow,
          "last_seen_at": timeNow,
          ...metadata,
        }
      },
    );
    var res = await client.post(
      Uri.parse("https://${p.baseUrl}/api/customers"),
      headers: {
        "content-type": "application/json",
      },
      body: jsonString,
    );
    var data = jsonDecode(res.body)["data"];
    c = PapercupsCustomer(
      createdAt: parseDateFromUTC(data["created_at"]),
      email: data["email"],
      externalId: data["external_id"],
      firstSeen: parseDateFromUTC(data["first_seen"]),
      id: data["id"],
      lastSeenAt: parseDateFromUTC(data["last_seen_at"]),
      updatedAt: parseDateFromUTC(data["updated_at"]),
      name: data["name"],
      phone: data["phone"],
    );
  } catch (e) {
    rethrow;
  }
  client.close();
  return c;
}
