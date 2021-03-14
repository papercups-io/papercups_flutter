/// This is teh class which contains all customer info.
class PapercupsCustomer {
  /// Date of Customer creation.
  DateTime? createdAt;

  /// Email of the customer.
  String? email;

  /// Name of the customer.
  String? name;

  /// Phone of the customer
  String? phone;

  /// External ID used to identify the customer with the Papercups API.
  String? externalId;

  /// The time where the customer was first seen.
  DateTime? firstSeen;

  /// The unique identifier of the customer on the Papercups system.
  String? id;

  /// When the customer was last seen.
  DateTime? lastSeen;

  /// When the customer details were last updated.
  DateTime? updatedAt;

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
