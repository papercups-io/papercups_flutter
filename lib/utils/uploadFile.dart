import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import '../models/models.dart';

Future<List<PapercupsAttachment>> uploadFile(
  Props p,
  String filePath,
) async {
  List<PapercupsAttachment>? pa = [];
  try {
    var uri = Uri.parse("https://" + p.baseUrl + "/api/upload");
    var client = MultipartRequest("POST", uri)
      ..fields['account_id'] = p.accountId
      ..files.add(await MultipartFile.fromPath('file', filePath));
    var res = await client.send();
    var charCodes = await res.stream.last;
    var body = String.fromCharCodes(charCodes as Uint8List);
    var data = jsonDecode(body)["data"];
    pa.add(
      PapercupsAttachment(
        id: data["id"],
        fileName: data["filename"],
        fileUrl: data["file_url"],
        contentType: data["content_type"],
      ),
    );
  } catch (e) {
    throw (e);
  }
  // client.close();
  return pa;
}
