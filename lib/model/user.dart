class UserModel {
  int id;
  String fullname;
  String email;
  DateTime emailVerifiedAt;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.fullname,
    required  this.email,
    required this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> _json) {
    return UserModel(
      id: _json['id'],
      fullname: _json['fullname'],
      email: _json['email'],
      emailVerifiedAt: DateTime.now(),
      role: _json['role'],
      createdAt: DateTime.parse(_json['created_at']),
      updatedAt: DateTime.parse(_json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt?.toIso8601String();
    data['role'] = this.role;
    data['created_at'] = this.createdAt.toIso8601String();
    data['updated_at'] = this.updatedAt.toIso8601String();
    return data;
  }
}
