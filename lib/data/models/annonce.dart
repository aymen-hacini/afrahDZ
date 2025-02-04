class AdModel {
  final int id;
  final String name;
  final String category;
  final String eventType;
  final String city;
  final String address;
  final double price;
  final String imageFullPath;
  final String? type;
  final double rating; // Add the rating field
  final DateTime date; // Change the type to DateTime


  AdModel({
    required this.id,
    required this.name,
    required this.category,
    required this.eventType,
    required this.city,
    required this.address,
    required this.price,
    required this.imageFullPath,
    this.type,
    required this.rating, // Add the rating field
    required this.date
  });

  // Factory method to create an instance from JSON
  factory AdModel.fromJson(Map<String, dynamic> json) {
    // Remove '/api/v1' from the image_full_path
    String imagePath = json['image_full_path'];
    if (imagePath.startsWith('/api')) {
      imagePath = imagePath.replaceFirst('/api', '');
    }

    return AdModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      eventType: json['eventType'],
      city: json['city'],
      address: json['address'],
      price: json['price'].toDouble(),
      imageFullPath: imagePath, // Use the modified image path
      type: json['type'],
      rating: json['rating'].toDouble(), // Parse the rating field
      date: DateTime.parse(json['date']), // Parse the date string into DateTime
    );
  }
}