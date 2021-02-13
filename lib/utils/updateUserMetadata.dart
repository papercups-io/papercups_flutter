// Imports
import 'dart:convert';

import 'package:http/http.dart';
import '../papercups_flutter.dart';

import '../models/models.dart';
import 'utils.dart';

/// This function is used to update customer details on the Papercups server.
Future<PapercupsCustomer> updateUserMetadata(
  Props p,
  String cId, {
  Client client,
}) async {
  if (client == null) {
    client = Client();
  }
  PapercupsCustomer c;
  var json = p.customer.toJsonString();
  try {
    var res = await client.put(
      Uri.https(p.baseUrl, "/api/customers/$cId/metadata"),
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
      },
      body: '{"metadata": ${json}}',
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
      lastSeen: data["last_seen"] != null
          ? parseDateFromUTC(data["last_seen"])
          : null,
      updatedAt: data["updated_at"] != null
          ? parseDateFromUTC(data["updated_at"])
          : null,
      name: data["name"],
      phone: data["phone"],
    );
  } catch (e) {
    c = null;
  }

  client.close();
  return c;
}
