import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

Future<PapercupsCustomer> getCustomerDetailsFromMetadata(
  Props p,
  PapercupsCustomer c,
  Function sc,
) async {
  var res = await get(
    Uri.https(
      p.baseUrl,
      "/api/customers/identify",
      {
        "external_id": p.customer.externalId,
        "account_id": p.accountId,
      },
    ),
  );
  var data = jsonDecode(res.body)["data"];
  c = PapercupsCustomer(
    id: data["customer_id"],
    externalId: p.customer.externalId,
    email: p.customer.email,
  );
  sc(c);
  return c;
}
