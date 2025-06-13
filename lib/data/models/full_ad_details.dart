class FullAdDetails {
  final int id;
  final String name;
  final String category;
  final String eventType;
  final String city;
  final String address;
  final String creationDate;
  final String? phone;
  final String mobile;
  final double price;
  final String? pricenature;
  final String? details;
  final int visits;
  final int likes;
  final int idmobmre;
  final String imageFullPath;
  final String? videoFullPath;
  final Map<String, dynamic> boost; // Updated to Map<String, dynamic>
  final List<AdImage> images;
  final List<String> actions; // New field
  final bool allowed; // New field
  final bool liked; // New field

  FullAdDetails({
    required this.id,
    required this.name,
    required this.category,
    required this.eventType,
    required this.city,
    required this.address,
    required this.creationDate,
    this.phone,
    required this.mobile,
    required this.price,
    this.pricenature,
    this.details,
    required this.visits,
    required this.likes,
    required this.idmobmre,
    required this.imageFullPath,
    required this.videoFullPath,
    required this.boost, // Updated to Map<String, dynamic>
    required this.images,
    required this.actions, // New field
    required this.allowed, // New field
    required this.liked, // New field
  });

  // Factory method to create an instance from JSON
  factory FullAdDetails.fromJson(Map<String, dynamic> json) {
    // Remove '/api/v1' from image and video paths
    String imagePath = json['image_full_path'];
    // if (imagePath.startsWith('/api')) {
    //   imagePath = imagePath.replaceFirst('/api/', '');
    // }

    String videoPath = json['video_full_path'] ?? '';
    // if (videoPath.startsWith('/api')) {
    //   videoPath = videoPath.replaceFirst('/api', '');
    // }

    // Handle the boost field
    Map<String, dynamic> boostData = {};
    if (json['boost'] is Map<String, dynamic>) {
      boostData = json['boost'];
    } else if (json['boost'] is List && json['boost'].isEmpty) {
      boostData = {}; // Set to empty map if boost is an empty array
    }

    return FullAdDetails(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      eventType: json['eventType'],
      city: json['city'],
      address: json['address'],
      creationDate: json['creationDate'],
      phone: json['phone'],
      mobile: json['mobile'],
      price: json['price'].toDouble(),
      pricenature: json['pricenature'],
      details: json['details'],
      visits: json['visits'],
      likes: json['likes'],
      idmobmre: json['idmobmre'],
      imageFullPath: imagePath, // Use the modified image path
      videoFullPath: videoPath, // Use the modified video path
      boost: boostData,
      // Use the handled boost data
      images: (json['images'] as List)
          .map((image) => AdImage.fromJson(image))
          .toList(),
      actions: List<String>.from(json['actions'] ?? []), // New field
      allowed: json['allowed'] ?? false, // New field
      liked: json['liked'] ?? false, // New field
    );
  }
}

class AdImage {
  final int id;
  final String imagePath;

  AdImage({
    required this.id,
    required this.imagePath,
  });

  // Factory method to create an instance from JSON
  factory AdImage.fromJson(Map<String, dynamic> json) {
    // Remove '/api/v1' from the image path
    String path = json['image_path'];
    // if (path.startsWith('/api')) {
    //   path = path.replaceFirst('/api', '');
    // }

    return AdImage(
      id: json['id'],
      imagePath: path, // Use the modified image path
    );
  }
}
