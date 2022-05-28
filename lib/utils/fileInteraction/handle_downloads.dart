import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:papercups_flutter/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

Future<void> handleDownloadStream(
  Stream<StreamedResponse> resp, {
  required File file,
  Function? onDownloading,
  Function? onDownloaded,
}) async {
  List<List<int>> chunks = [];

  onDownloading?.call();

  resp.listen((StreamedResponse r) {
    r.stream.listen((List<int> chunk) {
      if (r.contentLength == null) {
        if (kDebugMode) {
          print("Error");
        }
      }

      chunks.add(chunk);
    }, onDone: () async {
      final Uint8List bytes = Uint8List(r.contentLength ?? 0);
      int offset = 0;
      for (List<int> chunk in chunks) {
        bytes.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }
      await file.writeAsBytes(bytes);
      OpenFile.open(file.absolute.path);
      if (onDownloaded != null) {
        onDownloaded();
      }
    });
  });
}

Future<File> getAttachment(PapercupsAttachment attachment) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File? file = File(dir +
      Platform.pathSeparator +
      (attachment.id ?? "noId") +
      (attachment.fileName ?? "noName"));
  return file;
}

Future<bool> checkCachedFiles(PapercupsAttachment attachment) async {
  var file = await getAttachment(attachment);
  if (await file.exists()) {
    return true;
  }
  return false;
}
