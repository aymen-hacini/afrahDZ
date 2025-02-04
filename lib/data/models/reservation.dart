import 'dart:typed_data'; // Import for Uint8List
import 'package:afrahdz/data/models/full_ad_details.dart';

class ReservationModel {
  final int id;
  final String reservationDate;
  final String finalReservationDate;
  final String name;
  final String email;
  final String phone;
  final String type;
  String etat;
  final String date;
  final int idClient;
  final int idMember;
  final int idAnnonce;
  FullAdDetails? adDetails; // Include ad details
  Uint8List? imageBytes; // Nullable Uint8List for image

  ReservationModel({
    required this.id,
    required this.reservationDate,
    required this.finalReservationDate,
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    required this.etat,
    required this.date,
    required this.idClient,
    required this.idMember,
    required this.idAnnonce,
    this.adDetails, // Optional ad details
    this.imageBytes, // Optional image bytes
  });

  // Factory method to create a ReservationModel from JSON
  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      reservationDate: json['reservationDate'],
      finalReservationDate: json['finalreservationDate'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      etat: json['etat'],
      date: json['date'],
      idClient: json['idClient'],
      idMember: json['idMember'],
      idAnnonce: json['idAnnonce'],
      adDetails: null, // Ad details will be fetched separately
      imageBytes: null, // Image bytes will be fetched separately
    );
  }
}