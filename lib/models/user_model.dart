class UserModel {
  final String name;
  final String email;
  final String governorate;
  final String mobileNumber;
  final String nationalId;

  UserModel({
    required this.name,
    required this.email,
    required this.governorate,
    required this.mobileNumber,
    required this.nationalId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      governorate: map['governorate'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      nationalId: map['nationalId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'governorate': governorate,
      'mobileNumber': mobileNumber,
      'nationalId': nationalId,
    };
  }
}
