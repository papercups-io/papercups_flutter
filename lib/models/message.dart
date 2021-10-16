// Imports
import 'package:papercups_flutter/models/models.dart';

import 'customer.dart';

export 'user.dart';

/// This class is the class used for each message on the chat.
class PapercupsMessage {
  ///  The account ID in the Papercups syetem. Should match the one given in the definition.
  String? accountId;

  /// The body of the message (the text), may contain markdown.
  String? body;

  /// The ID of the conversation used to identify the room that the message originated from.
  String? conversationId;

  /// The date the message what created.
  DateTime? createdAt;
  String? customerId;
  String? id;

  /// The date the message was seen.
  DateTime? seenAt;

  /// The date the message was sent.
  DateTime? sentAt;

  /// The user which sent the message. Is nullable if the person sending is a customer.
  User? user;

  /// The customer which sent the message. Is nullable if the person sending is an agent.
  PapercupsCustomer? customer;

  /// The userID of the person sending. Is nullable is the person sending is a customer.
  int? userId;

  /// The file ids of files to be sent, could be null if message does not contain files
  List<String>? fileIds;

  /// the metadata of files attached
  List<PapercupsAttachment>? attachments;

  PapercupsMessage({
    this.accountId,
    this.body,
    this.conversationId,
    this.createdAt,
    this.customerId,
    this.id,
    this.seenAt,
    this.sentAt,
    this.user,
    this.userId,
    this.customer,
    this.fileIds,
    this.attachments,
  });

  PapercupsMessage copyWith({
    String? accountId,
    String? body,
    String? conversationId,
    DateTime? createdAt,
    String? customerId,
    String? id,
    DateTime? seenAt,
    DateTime? sentAt,
    User? user,
    PapercupsCustomer? customer,
    int? userId,
    List<String>? fileIds,
    List<PapercupsAttachment>? attachments,
  }) {
    return PapercupsMessage(
      accountId: accountId ?? this.accountId,
      body: body ?? this.body,
      conversationId: conversationId ?? this.conversationId,
      createdAt: createdAt ?? this.createdAt,
      customerId: customerId ?? this.customerId,
      id: id ?? this.id,
      seenAt: seenAt ?? this.seenAt,
      sentAt: sentAt ?? this.sentAt,
      user: user ?? this.user,
      customer: customer ?? this.customer,
      userId: userId ?? this.userId,
      fileIds: fileIds ?? this.fileIds,
      attachments: attachments ?? this.attachments,
    );
  }
}
