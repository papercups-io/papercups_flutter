import 'user.dart';
export 'user.dart';

class PapercupsMessage {
  String accountId;
  String body;
  String conversationId;
  DateTime createdAt;
  String customerId;
  String id;
  DateTime seenAt;
  DateTime sentAt;
  User user;
  int userId;

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
  });
}
