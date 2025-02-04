class CategorieModel {
  final String name;
  final int number;
  final String image;

  CategorieModel({
    required this.name,
    required this.number,
    required this.image,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
       // Remove '/api/v1' from the image_full_path
    String imagePath = json['image'];
    if (imagePath.startsWith('/api')) {
      imagePath = imagePath.replaceFirst('/api', '');
    }
    return CategorieModel(
      name: json['name'],
      number: json['number'],
      image: imagePath,
    );
  }
}