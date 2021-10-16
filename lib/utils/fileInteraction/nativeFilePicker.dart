import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papercups_flutter/models/models.dart';
import 'package:papercups_flutter/utils/fileInteraction/uploadFile.dart';
import 'package:papercups_flutter/widgets/alert.dart';

void nativeFilePicker(
    {required FileType type,
    required BuildContext context,
    required widget,
    required Function onUploadSuccess}) async {
  try {
    final _paths = (await FilePicker.platform.pickFiles(
      type: type,
    ))
        ?.files;
    if (_paths != null && _paths.first.path != null) {
      Alert.show(
        "Uploading...",
        context,
        textStyle: Theme.of(context).textTheme.bodyText2,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        gravity: Alert.bottom,
        duration: Alert.lengthLong,
      );
      List<PapercupsAttachment> attachments = await uploadFile(
        widget.props,
        filePath: _paths.first.path,
        onUploadProgress: (sentBytes, totalBytes) {
          Alert.show(
            "${(sentBytes * 100 / totalBytes).toStringAsFixed(2)}% uploaded",
            context,
            textStyle: Theme.of(context).textTheme.bodyText2,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            gravity: Alert.bottom,
            duration: Alert.lengthLong,
          );
        },
      );

      onUploadSuccess(attachments);
    }
  } on PlatformException catch (_) {
    Alert.show(
      "Failed to upload attachment",
      context,
      textStyle: Theme.of(context).textTheme.bodyText2,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      gravity: Alert.bottom,
      duration: Alert.lengthLong,
    );
    throw _;
  } catch (_) {
    Alert.show(
      "Failed to upload attachment",
      context,
      textStyle: Theme.of(context).textTheme.bodyText2,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      gravity: Alert.bottom,
      duration: Alert.lengthLong,
    );
    throw _;
  }
}
