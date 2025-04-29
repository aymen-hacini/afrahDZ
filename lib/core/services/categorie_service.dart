import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:dio/dio.dart';

class CategorieService {
  final Dio _dio = Dio(); // Use your Dio instance

  // Fetch all categories
  Future<List<CategorieModel>> fetchAllCategories() async {
    try {
      // Send the GET request to fetch categories
      final response = await _dio.get(
        ApiLinkNames.getAllCategories, // Replace with your API endpoint
        
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response data into a list of CategorieModel
        final List<dynamic> data = response.data['data']; // Adjust based on your API response structure
        final List<CategorieModel> categories = data
            .map((json) => CategorieModel.fromJson(json))
            .toList();
        return categories;
      } else {
        throw Exception("Impossible de récupérer les catégories");
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? "Impossible de récupérer les categories";
    }
  }
}