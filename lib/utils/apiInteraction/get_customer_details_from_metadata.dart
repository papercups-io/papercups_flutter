// Imports
import 'dart:convert';

import 'package:http/http.dart';
import '../../models/models.dart';

/// This funtction is used to get the customer details from Papercups.
/// This is the function responsible for finding the Customer's ID.
Future<PapercupsCustomer> getCustomerDetailsFromMetadata(
  PapercupsProps p,
  PapercupsCustomer? c,
  Function sc, {
  Client? client,
}) async {
  client ??= Client();
  try {
    // HTTP client getting info
    var res = await client.get(
      Uri.https(
        p.baseUrl,
        "/api/customers/identify",
        {
          "external_id": p.customer!.externalId,
          "account_id": p.accountId,
        },
      ),
    );
    //Decoding JSON
    var data = jsonDecode(res.body)["data"];
    // Generating the Papercups customer data.
    c = PapercupsCustomer(
      id: data["customer_id"],
      externalId: p.customer?.externalId,
      email: p.customer?.email,
      createdAt: c?.createdAt,
      firstSeen: c?.firstSeen,
      lastSeenAt: c?.lastSeenAt,
      name: p.customer?.name,
      phone: p.customer?.otherMetadata?["phoneNumber"],
      updatedAt: c?.updatedAt,
    );
  } catch (e) {
    rethrow;
  }
  // Function to set the client.
  if (c.id != null) {
    sc(c);
  }
  // Closing HTTP client.
  client.close();
  // Returns customer.
  return c;
}
