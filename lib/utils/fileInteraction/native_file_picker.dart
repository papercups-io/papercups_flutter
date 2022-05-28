// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papercups_flutter/models/models.dart';
import 'package:papercups_flutter/utils/fileInteraction/upload_file.dart';
import 'package:papercups_flutter/widgets/widgets.dart';

void nativeFilePicker({
  required FileType type,
  required BuildContext context,
  required SendMessage widget,
  required Function onUploadSuccess,
}) async {
  try {
    final paths = (await FilePicker.platform.pickFiles(
      type: type,
    ))
        ?.files;
    if (paths?.first.path != null) {
      Alert.show(
        widget.props.translations.attachmentUploadingText,
        context,
        textStyle: widget.props.style.chatUploadingAlertTextStyle ??
            Theme.of(context).textTheme.bodyText2,
        backgroundColor: widget.props.style.chatUploadingAlertBackgroundColor ??
            Theme.of(context).bottomAppBarColor,
        gravity: Alert.bottom,
        duration: Alert.lengthLong,
      );
      List<PapercupsAttachment> attachments = await uploadFile(
        widget.props,
        filePath: paths?.first.path,
        onUploadProgress: (sentBytes, totalBytes) {
          Alert.show(
            "${(sentBytes * 100 / totalBytes).toStringAsFixed(2)}% ${widget.props.translations.uploadedText}",
            context,
            textStyle: widget.props.style.chatUploadingAlertTextStyle ??
                Theme.of(context).textTheme.bodyText2,
            backgroundColor:
                widget.props.style.chatUploadingAlertBackgroundColor ??
                    Theme.of(context).bottomAppBarColor,
            gravity: Alert.bottom,
            duration: Alert.lengthLong,
          );
        },
      );

      onUploadSuccess(attachments);
    }
  } on PlatformException catch (_) {
    Alert.show(
      widget.props.translations.attachmentUploadErrorText,
      context,
      textStyle: widget.props.style.chatUploadErrorAlertTextStyle ??
          Theme.of(context).textTheme.bodyText2,
      backgroundColor: widget.props.style.chatUploadErrorAlertBackgroundColor ??
          Theme.of(context).bottomAppBarColor,
      gravity: Alert.bottom,
      duration: Alert.lengthLong,
    );
    rethrow;
  } catch (_) {
    Alert.show(
      widget.props.translations.attachmentUploadErrorText,
      context,
      textStyle: widget.props.style.chatUploadErrorAlertTextStyle ??
          Theme.of(context).textTheme.bodyText2,
      backgroundColor: widget.props.style.chatUploadErrorAlertBackgroundColor ??
          Theme.of(context).bottomAppBarColor,
      gravity: Alert.bottom,
      duration: Alert.lengthLong,
    );
    rethrow;
  }
}
