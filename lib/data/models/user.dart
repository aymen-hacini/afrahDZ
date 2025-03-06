import 'dart:typed_data';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String wilaya;
  final String? fixe;
  final int age;
  final Uint8List? profilePicture; // Binary data for the profile picture

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.wilaya,
      required this.phone,
      required this.age,
      
      this.fixe,
      this.profilePicture});

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      wilaya: json['wilaya'],
      phone: json['phone'],
      age: json['age'],
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
      'phone': phone,
      'age': age,
      'mobail': fixe ?? "",
      'profilePicture': profilePicture, // Binary data (nullable)
    };
  }
}
