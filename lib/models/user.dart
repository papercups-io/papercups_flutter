class User {
  DateTime createdAt;
  DateTime disabledAt;
  String email;
  int id;
  String role;
  String fullName;
  String profilePhotoUrl;

  User({
    this.createdAt,
    this.disabledAt,
    this.email,
    this.id,
    this.role,
    this.fullName,
    this.profilePhotoUrl,
  });
}
