import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

Future<List<PapercupsAttachment>> uploadFile(Props p, String filePath,
    {OnUploadProgressCallback? onUploadProgress}) async {
  List<PapercupsAttachment>? pa = [];
  try {
    var uri = Uri.parse("https://" + p.baseUrl + "/api/upload");
    final httpClient = HttpClient();
    final request = await httpClient.postUrl(uri);
    var client = MultipartRequest("POST", uri)
      ..fields['account_id'] = p.accountId
      ..files.add(await MultipartFile.fromPath('file', filePath));

    var msStream = client.finalize();
    var totalByteLength = client.contentLength;
    request.contentLength = totalByteLength;

    request.headers.set(
      HttpHeaders.contentTypeHeader,
      client.headers[HttpHeaders.contentTypeHeader] ?? '',
    );
    int byteCount = 0;

    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();

    var statusCode = httpResponse.statusCode;

    if (statusCode ~/ 100 != 2) {
      throw Exception(
          'Error uploading file, Status code: ${httpResponse.statusCode}');
    } else {
      var body = await convertToString(httpResponse);
      var data = jsonDecode(body)["data"];
      pa.add(
        PapercupsAttachment(
          id: data["id"],
          fileName: data["filename"],
          fileUrl: data["file_url"],
          contentType: data["content_type"],
        ),
      );
    }
  } catch (e) {
    throw (e);
  }
  return pa;
}

Future<String> convertToString(HttpClientResponse response) {
  var completer = Completer<String>();
  var contents = StringBuffer();
  response.transform(utf8.decoder).listen((String data) {
    contents.write(data);
  }, onDone: () => completer.complete(contents.toString()));
  return completer.future;
}
