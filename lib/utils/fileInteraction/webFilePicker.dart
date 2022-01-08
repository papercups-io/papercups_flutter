import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:papercups_flutter/models/attachment.dart';
import 'package:papercups_flutter/utils/fileInteraction/uploadFile.dart';
import 'package:papercups_flutter/widgets/alert.dart';

Future<void> webFilePicker({
  required BuildContext context,
  required Function onUploadSuccess,
  required widget,
}) async {
  try {
    var picked = await FilePicker.platform.pickFiles();

    if (picked != null && picked.files.first.bytes != null) {
      Alert.show(
        widget.props.translations.attachmentUploadingText,
        context,
        textStyle: Theme.of(context).textTheme.bodyText2,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        gravity: Alert.bottom,
        duration: Alert.lengthLong,
      );
      List<PapercupsAttachment> attachments = await uploadFile(
        widget.props,
        fileBytes: picked.files.first.bytes,
        fileName: picked.files.first.name,
      );
      onUploadSuccess(attachments);
    }
  } on Exception catch (_) {
    Alert.show(
      widget.props.translations.attachmentUploadErrorText,
      context,
      textStyle: Theme.of(context).textTheme.bodyText2,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      gravity: Alert.bottom,
      duration: Alert.lengthLong,
    );
  }
}
