import 'package:universal_io/io.dart';

class PapercupsAttachment {
  String? id;
  String? fileName;
  String? fileUrl;
  String? contentType;
  File? file;

  PapercupsAttachment(
      {this.id, this.fileName, this.fileUrl, this.contentType, this.file});
}
