import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:papercups_flutter/models/attachment.dart';
import 'package:papercups_flutter/models/classes.dart';
import 'package:papercups_flutter/utils/fileInteraction/downloadFile.dart';
import 'package:papercups_flutter/utils/fileInteraction/handleDownloads.dart';
import 'package:papercups_flutter/utils/utils.dart';
import 'package:universal_io/io.dart';

class Attachment extends StatefulWidget {
  const Attachment(
      {required this.userSent,
      required this.props,
      required this.fileName,
      required this.textColor,
      required this.msgHasText,
      required this.attachment,
      Key? key})
      : super(key: key);

  final bool userSent;
  final Props props;
  final String fileName;
  final Color textColor;
  final bool msgHasText;
  final PapercupsAttachment attachment;

  @override
  State<Attachment> createState() => _AttachmentState();
}

class _AttachmentState extends State<Attachment> {
  bool downloading = false;
  bool downloaded = false;
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    checkCachedFiles(widget.attachment).then((value) {
      if (value) {
        downloaded = true;
        if (mounted) {
          setState(() {});
        }
      }
    });

    return InkWell(
      onTap: () async {
        if (kIsWeb && !uploading) {
          String url = widget.attachment.fileUrl ?? '';
          downloadFileWeb(url);
        } else if ((Platform.isAndroid ||
                Platform.isIOS ||
                Platform.isLinux ||
                Platform.isMacOS ||
                Platform.isWindows) &&
            !downloading &&
            !uploading) {
          var file = await getAttachment(widget.attachment);
          if (file.existsSync()) {
            print("Cached at " + file.absolute.path);
            OpenFile.open(file.absolute.path);
            downloaded = true;
          } else {
            Stream<StreamedResponse> resp =
                await downloadFile(widget.attachment.fileUrl ?? '');
            handleDownloadStream(resp, file: file, onDownloaded: () {
              downloaded = true;
              downloading = false;
              setState(() {});
            }, onDownloading: () {
              downloaded = false;
              downloading = true;
              setState(() {});
            });
          }
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.userSent
              ? darken(widget.props.primaryColor!, 20)
              : Theme.of(context).brightness == Brightness.light
                  ? brighten(Theme.of(context).disabledColor, 70)
                  : Color(0xff282828),
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: !widget.msgHasText ? 0 : 5),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.props.primaryColor,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (downloading || uploading)
                    CircularProgressIndicator(
                      color: Theme.of(context).canvasColor,
                    ),
                  Icon(
                    !downloaded
                        ? uploading
                            ? Icons.upload_rounded
                            : Icons.download_rounded
                        : Icons.attach_file_rounded,
                    color: Theme.of(context).canvasColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                widget.fileName,
                style: TextStyle(
                  color: widget.userSent
                      ? widget.textColor
                      : Theme.of(context).textTheme.bodyText1!.color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
