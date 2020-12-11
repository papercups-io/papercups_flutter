class PapercupsCustomer {
  DateTime createdAt;
  String email;
  String name;
  String phone;
  String externalId;
  DateTime firstSeen;
  String id;
  DateTime lastSeen;
  DateTime updatedAt;

  PapercupsCustomer({
    this.createdAt,
    this.email,
    this.externalId,
    this.firstSeen,
    this.id,
    this.lastSeen,
    this.updatedAt,
    this.name,
    this.phone,
  });
}
