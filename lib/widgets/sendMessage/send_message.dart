//Imports
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:papercups_flutter/utils/fileInteraction/native_file_picker.dart';
import 'package:papercups_flutter/utils/fileInteraction/web_file_picker.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import '../alert.dart';

/// Send message text box.
class SendMessage extends StatefulWidget {
  const SendMessage({
    Key? key,
    this.customer,
    this.setCustomer,
    this.setConversation,
    this.conversationChannel,
    this.setConversationChannel,
    this.conversation,
    this.socket,
    this.setState,
    this.messages,
    this.sending,
    required this.props,
    required this.textColor,
    this.showDivider = true,
  }) : super(key: key);

  final PapercupsProps props;
  final PapercupsCustomer? customer;
  final Function? setCustomer;
  final Function? setState;
  final Function? setConversation;
  final Function? setConversationChannel;
  final PhoenixChannel? conversationChannel;
  final Conversation? conversation;
  final PhoenixSocket? socket;
  final List<PapercupsMessage>? messages;
  final bool? sending;
  final Color textColor;
  final bool showDivider;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final _msgController = TextEditingController();

  final _msgFocusNode = FocusNode();

  @override
  void dispose() {
    _msgController.dispose();
    _msgFocusNode.dispose();
    super.dispose();
  }

  void triggerSend() {
    _sendMessage(
      _msgFocusNode,
      _msgController,
      widget.customer,
      widget.props,
      widget.setCustomer,
      widget.conversation,
      widget.setConversation,
      widget.setConversationChannel,
      widget.conversationChannel,
      widget.socket,
      widget.setState,
      widget.messages,
      widget.sending,
    );
  }

  void _onUploadSuccess(List<PapercupsAttachment> attachments) {
    if (attachments.isNotEmpty) {
      List<String> fileIds = attachments.map((e) => e.id ?? "").toList();
      _sendMessage(
        _msgFocusNode,
        _msgController,
        widget.customer,
        widget.props,
        widget.setCustomer,
        widget.conversation,
        widget.setConversation,
        widget.setConversationChannel,
        widget.conversationChannel,
        widget.socket,
        widget.setState,
        widget.messages,
        widget.sending,
        attachments,
        fileIds,
        true,
      );
      Alert.show(
        widget.props.translations.attachmentUploadedText,
        context,
        textStyle: widget.props.style.chatUploadingAlertTextStyle ??
            Theme.of(context).textTheme.bodyMedium,
        backgroundColor: widget.props.style.chatUploadingAlertBackgroundColor ??
            BottomAppBarTheme.of(context).color!,
        gravity: Alert.bottom,
        duration: Alert.lengthLong,
      );
    }
  }

// TODO: Separate this widget
  Widget _getFilePicker() {
    if (kIsWeb) {
      return IconButton(
        splashRadius: 20,
        icon: Transform.rotate(
          angle: 0.6,
          child: const Icon(
            Icons.attach_file,
            size: 18,
          ),
        ),
        onPressed: () => webFilePicker(
          context: context,
          onUploadSuccess: _onUploadSuccess,
          widget: widget,
        ),
      );
    } else if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isWindows ||
        Platform.isLinux ||
        Platform.isMacOS) {
      return PopupMenuButton<FileType>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        icon: Transform.rotate(
          angle: 0.6,
          child: const Icon(
            Icons.attach_file,
            size: 18,
          ),
        ),
        onSelected: (type) => nativeFilePicker(
          context: context,
          onUploadSuccess: _onUploadSuccess,
          type: type,
          widget: widget,
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<FileType>>[
          PopupMenuItem<FileType>(
            value: FileType.any,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: widget.props.style.primaryColor,
                foregroundColor: widget.textColor,
                child: const Icon(Icons.insert_drive_file_outlined),
              ),
              title: Text(widget.props.translations.fileText),
              contentPadding: const EdgeInsets.all(0),
            ),
          ),
          PopupMenuItem<FileType>(
            value: FileType.image,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: widget.props.style.primaryColor,
                foregroundColor: widget.textColor,
                child: const Icon(Icons.image_outlined),
              ),
              title: Text(widget.props.translations.imageText),
              contentPadding: const EdgeInsets.all(0),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 55,
      ),
      decoration: widget.props.style.sendMessageBoxDecoration ??
          BoxDecoration(
            color: Theme.of(context).cardColor,
            border: widget.showDivider
                ? Border(
                    top: BorderSide(color: Theme.of(context).dividerColor),
                  )
                : null,
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                color: Theme.of(context).shadowColor.withOpacity(0.1),
              )
            ],
          ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                keyboardAppearance:
                    widget.props.style.sendMessageKeyboardAppearance,
                style: widget.props.style.sendMessageInputTextStyle,
                decoration: widget
                        .props.style.sendMessagePlaceholderInputDecoration ??
                    InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.props.translations.newMessagePlaceholder,
                      hintStyle:
                          widget.props.style.sendMessagePlaceholderTextStyle,
                    ),
                onSubmitted: (_) => triggerSend(),
                controller: _msgController,
                focusNode: _msgFocusNode,
              ),
            ),
            _getFilePicker(),
            InkWell(
                customBorder: const CircleBorder(),
                onTap: triggerSend,
                child: Container(
                  height: 36,
                  width: 36,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: widget.props.style.primaryColor,
                    gradient: widget.props.style.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: widget.props.sendIcon ??
                      Icon(
                        Icons.send,
                        color: widget.textColor,
                        size: 16,
                      ),
                )),
          ],
        ),
      ),
    );
  }
}

/// Send message function
void _sendMessage(
  FocusNode fn,
  TextEditingController tc,
  PapercupsCustomer? cu,
  PapercupsProps p,
  Function? setCust,
  Conversation? conv,
  Function? setConv,
  Function? setConvChannel,
  PhoenixChannel? conversationChannel,
  PhoenixSocket? socket,
  Function? setState,
  List<PapercupsMessage>? messages,
  bool? sending, [
  List<PapercupsAttachment>? attachments,
  List<String>? fileIds,
  bool mediaMessage = false,
]) {
  final text = tc.text;
  fn.requestFocus();
  if (text.trim().isEmpty && fileIds == null) return;
  tc.clear();
  var timeNow = DateTime.now().toUtc();

  setState!(
    () {
      messages!.add(
        PapercupsMessage(
          body: text,
          createdAt: timeNow.toLocal(),
          sentAt: timeNow.toLocal(),
          customer: PapercupsCustomer(),
          fileIds: fileIds,
          attachments: attachments,
        ),
      );
    },
    stateMsg: true,
    animate: true,
  );

  if (conversationChannel == null ||
      conversationChannel.state == PhoenixChannelState.closed) {
    getCustomerDetails(p, cu, setCust).then(
      (customerDetails) {
        setCust!(customerDetails);
        getConversationDetails(p, conv!, customerDetails, setConv!).then(
          (conversationDetails) {
            var conv = joinConversationAndListen(
              messages: messages,
              convId: conversationDetails.id!,
              conversation: conversationChannel,
              socket: socket!,
              setState: setState,
              setChannel: setConvChannel!,
            )!;
            conv.push(
              "shout",
              {
                "body": text,
                "customer_id": customerDetails.id,
                "sent_at": timeNow.toIso8601String(),
                if (mediaMessage) "file_ids": fileIds,
              },
            );
            setState(() {});
          },
        );
      },
    );
  } else {
    conversationChannel.push(
      "shout",
      {
        "body": text,
        "customer_id": cu!.id,
        "sent_at": timeNow.toIso8601String(),
        if (mediaMessage) "file_ids": fileIds,
      },
    );
  }
  setState(() {});
}
