// Imports
import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

/// This funtction is used to get the customer details from Papercups.
/// This is the function responsible for finding the Customer's ID.
Future<PapercupsCustomer> getCustomerDetailsFromMetadata(
  Props p,
  PapercupsCustomer? c,
  Function sc, {
  Client? client,
}) async {
  if (client == null) {
    client = Client();
  }
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
      externalId: c == null ? null : c.externalId,
      email: c == null ? null : c.email,
      createdAt: c == null ? null : c.createdAt,
      firstSeen: c == null ? null : c.firstSeen,
      lastSeenAt: c == null ? null : c.lastSeenAt,
      name: c == null ? null : c.name,
      phone: c == null ? null : c.phone,
      updatedAt: c == null ? null : c.updatedAt,
    );
  } catch (e) {
    throw (e);
  }
  // Function to set the client.
  if(c.id != null){
    sc(c);
  }
  // Closing HTTP client.
  client.close();
  // Returns customer.
  return c;
}
