// import 'dart:typed_data';
// import 'dart:io';

import 'package:http/http.dart';
// import 'package:path_provider/path_provider.dart';

Future<Stream<StreamedResponse>> downloadFile(String url) async {
  var httpClient = Client();
  var request = Request('GET', Uri.parse(url));
  var response = httpClient.send(request);

  return response.asStream();
}
