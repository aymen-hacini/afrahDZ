import 'dart:typed_data';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String wilaya;
  final String? location;
  final String? fixe;
  final int? age;
  final int? codeuse;
  final String? code;
  final Uint8List? profilePicture; // Binary data for the profile picture

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.wilaya,
      required this.location,
      required this.phone,
      required this.age,
      required this.code,
      required this.codeuse,
      
      this.fixe,
      this.profilePicture});

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      wilaya: json['wilaya'],
      location: json['location'] ?? "",
      phone: json['phone'],
      age: json['age'] ?? 0,
      code: json['code'] ?? "",
      codeuse: json['code_use'] ?? 0,
      fixe: json['mobail'] ?? "",
      profilePicture: null, // Profile picture will be fetched separately
    );
  }

  // Convert UserModel to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'wilaya': wilaya,
      'location': location ?? "",
      'phone': phone,
      'age': age ?? 0,
      'code': code ?? "",
      'code_use': codeuse ?? 0,
      'mobail': fixe ?? "",
      'profilePicture': profilePicture, // Binary data (nullable)
    };
  }
}
