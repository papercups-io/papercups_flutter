import 'package:universal_io/io.dart';

class PapercupsAttachment {
  String? id;
  String? fileName;
  String? fileUrl;
  String? contentType;
  File? file;

  PapercupsAttachment(
      {this.id, this.fileName, this.fileUrl, this.contentType, this.file});

  PapercupsAttachment copyWith({
    String? id,
    String? fileName,
    String? fileUrl,
    String? contentType,
    File? file,
  }) {
    return PapercupsAttachment(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      fileUrl: fileUrl ?? this.fileUrl,
      contentType: contentType ?? this.contentType,
      file: file ?? this.file,
    );
  }
}
