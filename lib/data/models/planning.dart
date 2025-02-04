import 'dart:typed_data';

class Reservation {
  final int id;
  final String startDate;
  final String finalDate;
  final String etat;
  final String dateCreation;

  Reservation({
    required this.id,
    required this.startDate,
    required this.finalDate,
    required this.etat,
    required this.dateCreation,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      startDate: json['StartDate'],
      finalDate: json['FinalDate'],
      etat: json['etat'],
      dateCreation: json['DateCreation'],
    );
  }
}

class Membre {
  final int id;
  final String name;
  final String city;
  final String email;
  final String phone;
   Uint8List? profilePicture; // Binary data for the profile picture


  Membre({
    required this.id,
    required this.name,
    required this.city,
    required this.email,
    required this.phone
,this.profilePicture
  });

  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      email: json['email'],
      phone: json['phone'],
      profilePicture: null
    );
  }
}

class Annonce {
  final int id;
  final String name;
  final String city;
  final String address;
  final int price;
  final String imageFullPath;

  Annonce({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.price,
    required this.imageFullPath,
  });

  factory Annonce.fromJson(Map<String, dynamic> json) {
      // Remove '/api/v1' from image and video paths
    String imagePath = json['image_full_path'];
    if (imagePath.startsWith('/api')) {
      imagePath = imagePath.replaceFirst('/api', '');
    }


    return Annonce(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      price: json['price'],
      imageFullPath: imagePath,
    );
  }
}

class PlanningModel {
  final Reservation reservation;
  final Membre membre;
  final Annonce annonce;

  PlanningModel({
    required this.reservation,
    required this.membre,
    required this.annonce,
  });

   factory PlanningModel.fromJson(Map<String, dynamic> json, {required String userRole}) {
    // Determine the key to use for the 'membre' field based on the user's role
    final membreKey = userRole == 'client' ? 'membre' : 'client';

    return PlanningModel(
      reservation: Reservation.fromJson(json['reservation']),
      membre: Membre.fromJson(json[membreKey]), // Use the determined key
      annonce: Annonce.fromJson(json['annonce']),
    );
  }
}