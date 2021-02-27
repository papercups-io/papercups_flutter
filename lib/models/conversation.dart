import 'message.dart';

/// This is the class which contains the details of the conversation.
class Conversation {
  /// The account ID used for the conversation.
  String accountId;

  /// Who has the conversation assigned on the papercups dashboard.
  String asigneeId;

  /// When the conversation was created.
  String createdAt;

  /// The customer ID, should be unique to the person,
  /// may be assigned to multiple conversations.
  String customerId;

  /// Unique ID used to identify the conversation.
  String id;

  /// How much priority the ocnvesation has.
  String priority;

  /// If the convesation has been read by an agent.
  bool read;

  /// The status of a conversation, can be open or closed.
  String status;

  /// The messages which are part of the conversation
  List<PapercupsMessage> messages;

  Conversation({
    this.accountId,
    this.asigneeId,
    this.createdAt,
    this.customerId,
    this.id,
    this.priority,
    this.read,
    this.status,
  });
}
