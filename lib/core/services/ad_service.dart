import 'dart:convert';
import 'dart:io';
import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:afrahdz/data/models/full_ad_details.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class AdService {
  final GetStorage storage = GetStorage();
  final dio = Dio();

  Future<void> createAd(
      {required File firstImage,
      required List<File> additionalImages,
      File? video,
      required String name,
      required String category,
      required String eventType,
      required String city,
      required String address,
      required String mobile,
      required String memberID,
      required String price,
      required String description}) async {
    final url = ApiLinkNames.createAD; // Replace with your API URL

    try {
      final token = storage.read('token');

      if (token == null || token.isEmpty) {
        throw Exception('Token is missing. Please log in again.');
      }

      // Create FormData for multipart request
      final formData = FormData();

      // Add the first image to the 'image' field
      formData.files.add(MapEntry(
        'image', // Ensure this matches the server's expected field name
        await MultipartFile.fromFile(firstImage.path),
      ));

      // Add the remaining images to the 'images[]' array
      for (var image in additionalImages) {
        formData.files.add(MapEntry(
          'images[]', // Ensure this matches the server's expected field name
          await MultipartFile.fromFile(image.path),
        ));
      }

      // Add the video to the 'video' field
      if (video != null) {
        formData.files.add(MapEntry(
          'video', // Field name for the video
          await MultipartFile.fromFile(video.path),
        ));
      }

      // Add other fields (e.g., name, category, etc.)
      formData.fields.addAll([
        MapEntry('name', name),
        MapEntry('category', category),
        MapEntry('eventType', eventType),
        MapEntry('city', city),
        MapEntry('address', address),
        MapEntry('mobile', mobile),
        MapEntry('idMember', memberID),
        MapEntry('price', price),
        MapEntry('details', description),
      ]);

      // Send the POST request using Dio
      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'multipart/form-data', // Set content type
        }, preserveHeaderCase: true),
      );

      // Check the response
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception("Impossible de créer l'annonce");
      }
    } catch (e) {
      throw Exception("Impossible de créer l'annonce");
    }
  }

  // Function to update an ad with JSON payload
  Future<void> updateAd({
    required int adId,
    required String name,
    required String category,
    required String eventType,
    required String city,
    required String address,
    required String price,
    File? image,
    List<File>? images,
    File? video, // Optional video file
  }) async {
    try {
      // Retrieve the JWT token from local storage
      final String? token = storage.read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      // Convert files to Base64 strings
      String? imageBase64;
      final imageBytes = await image!.readAsBytes();
      imageBase64 = base64Encode(imageBytes);

      List<String>? imagesBase64;
      imagesBase64 = [];
      for (final file in images!) {
        final fileBytes = await file.readAsBytes();
        imagesBase64.add(base64Encode(fileBytes));
      }

      String? videoBase64;
      if (video != null) {
        final videoBytes = await video.readAsBytes();
        videoBase64 = base64Encode(videoBytes);
      }

      // Prepare the JSON payload
      final Map<String, dynamic> payload = {
        'name': name,
        'category': category,
        'eventType': eventType,
        'city': city,
        'address': address,
        'image': imageBase64,
        'images': '$imagesBase64',
        'price': price,
        if (videoBase64 != null) 'video': videoBase64,
      };

      // Send the PUT request to update the ad
      await dio.put(
        '${ApiLinkNames.editAd}/$adId', // Replace with your API endpoint
        data: payload,
        options: Options(headers: {
          'Authorization': 'Bearer $token', // Include the Bearer token
          'Content-Type': 'application/json', // Set content type to JSON
        }, preserveHeaderCase: true),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        // Handle 422 error
        final errorResponse = e.response?.data;

        // Example: Extract and display error messages
        if (errorResponse != null && errorResponse['errors'] != null) {
          final errors = errorResponse['errors'] as Map<String, dynamic>;
          errors.forEach((field, messages) {});
        }
      } else {
        throw Exception("Erreur lors de la mise à jour de l'annonce");
      }
    }
  }


Future<List<AdModel>> getVipAds({int page = 1, int perPage = 30}) async {
  try {
    // Add pagination parameters to the request
    final response = await dio.get(
      ApiLinkNames.getVipads, // Replace with your API endpoint
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );

    // Check the response status code
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Parse the JSON response
      final Map<String, dynamic> responseBody = response.data;
      final List<dynamic> data = responseBody['data'];

      // Extract pagination info from the response

      // Convert JSON data to a list of AdModel objects
      final List<AdModel> ads = data.map((ad) => AdModel.fromJson(ad)).toList();

      // Return the ads along with pagination info (optional)
      return ads;
    } else {
      throw Exception('Impossible de récupérer les annonces');
    }
  } catch (e) {
    throw Exception('Impossible de récupérer les annonces: $e');
  }
}
  // Function to fetch vip ads
  Future<List<AdModel>> getMemberAds(int memberId) async {
    try {
      final response = await dio.get(
        "${ApiLinkNames.getMemberAds}/$memberId", // Replace with your API endpoint
      );

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the JSON response
        final Map<String, dynamic> responseBody = response.data;
        final List<dynamic> data = responseBody['data'];

        // Convert JSON data to a list of AdModel objects
        final List<AdModel> ads =
            data.map((ad) => AdModel.fromJson(ad)).toList();
        return ads;
      } else {
        throw Exception('Impossible  ');
      }
    } catch (e) {
      throw Exception('Impossible ');
    }
  }

  // Function to fetch gold ads
  Future<List<AdModel>> getGoldads(
      String location, String category, String fete,{int page = 1, int perPage = 30}) async {
    try {
      final response = await dio.get(
        "${ApiLinkNames.getGoldads}?city=$location&category=$category&eventType=$fete",  queryParameters: {
        'page': page,
        'per_page': perPage,
      },// Replace with your API endpoint
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseBody = response.data;
        final List<dynamic> data = responseBody['data'];

        // Convert JSON data to a list of AdModel objects
        final List<AdModel> ads =
            data.map((ad) => AdModel.fromJson(ad)).toList();

        return ads;
      } else {
        throw Exception('Impossible de récupérer les annonces');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les annonces');
    }
  }

  // Function to fetch all ads
  Future<List<AdModel>> getNormalads(
      String location, String category, String fete) async {
    try {
      final response = await dio.get(
        "${ApiLinkNames.getAllads}?city=$location&category=$category&eventType=$fete", // Replace with your API endpoint
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseBody = response.data;
        final List<dynamic> data = responseBody['data'];

        // Convert JSON data to a list of AdModel objects
        final List<AdModel> ads =
            data.map((ad) => AdModel.fromJson(ad)).toList();
        return ads;
      } else {
        throw Exception('Impossible de récupérer les annonces');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les annonces');
    }
  }

  // Function to fetch all ads
  Future<List<AdModel>> searchAdsbyName(
      String name, String location, String category) async {
    try {
      final response = await dio.get(
        "${ApiLinkNames.getAllads}?name[like]=$name&city=$location&category=$category", // Replace with your API endpoint
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseBody = response.data;
        final List<dynamic> data = responseBody['data'];

        // Convert JSON data to a list of AdModel objects
        final List<AdModel> ads =
            data.map((ad) => AdModel.fromJson(ad)).toList();
        return ads;
      } else {
        throw Exception('Impossible de récupérer les annonces');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les annonces');
    }
  }

  // Function to fetch full ad details by ID
  Future<FullAdDetails> getFullAdDetails(int adId) async {
    final token = storage.read('token');

    try {
      dio.interceptors.add(LogInterceptor(
          request: true, requestBody: true, error: true, responseBody: true));
      // Send the GET request to fetch ad details
      final response = await dio.get(
        controller.isLoggedIn
            ? '${ApiLinkNames.getAdDetailswithVisite}/$adId'
            : '${ApiLinkNames.getAdDetails}/$adId', // Replace with your API endpoint
        options: Options(
            headers:
                controller.isLoggedIn ? {"Authorization": "Bearer $token"} : {},
            preserveHeaderCase: true),
      );

      // Check if the request was successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response data into FullAdDetails
        final Map<String, dynamic> data = response.data['data'];
        return FullAdDetails.fromJson(data);
      } else {
        throw Exception('Impossible de récupérer les annonces');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les annonces');
    }
  }

  // Fetch all announces
  Future<List<AdModel>> getMyannonces() async {
    try {
      // Retrieve the JWT token from local storage
      final token = GetStorage().read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      // Send the GET request to fetch all announces
      final response = await dio.get(
        ApiLinkNames.getMyAds, // Replace with your API endpoint
        options: Options(headers: {
          'Authorization': 'Bearer $token', // Include the token in the headers
        }, preserveHeaderCase: true),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response data into a list of AdModel
        final List<dynamic> data = response.data['data'];
        final List<AdModel> announces =
            data.map((json) => AdModel.fromJson(json)).toList();
        return announces;
      } else {
        throw Exception('Impossible de récupérer les annonces');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les annonces');
    }
  }

  // Method to delete a reservation
  Future<bool> deleteAnnonce(int annonceID) async {
    try {
      // Retrieve the JWT token from local storage
      final token = GetStorage().read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }
      final response = await dio.delete(
        '${ApiLinkNames.deleteAd}/$annonceID',
        options: Options(headers: {
          'Authorization': 'Bearer $token', // Include the token in the headers
        }, preserveHeaderCase: true),
      );

      if (response.statusCode == 200) {
        return true; // Deletion successful
      } else {
        return false; // Deletion failed
      }
    } catch (e) {
      return false; // Deletion failed
    }
  }

  // Boost an ad with a multipart POST request
  Future<void> boostAd({
    required int duration,
    required double price,
    required int idAnnonce,
    required String type,
    required String imageUrl, // Path to the image file
  }) async {
    try {
      // Retrieve the JWT token from local storage
      final token = GetStorage().read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }
      // Retrieve the idMember (sub) from the token
      final idMember = getMemberIdFromToken();
      if (idMember == null) {
        throw Exception('No idMember found in the token. Please log in again.');
      }
      final imageFile = await downloadImage(imageUrl);

      // Create FormData for the multipart request
      final formData = FormData.fromMap({
        'duration': duration,
        'price': price,
        'idMember': idMember,
        'idAnnonce': idAnnonce,
        'type': type,
        'image': await MultipartFile.fromFile(
          imageFile.path,
        ),
      });

      // Send the multipart POST request to boost the ad
      final response = await dio.post(
        ApiLinkNames.boostAd, // Replace with your API endpoint
        data: formData,
        options: Options(headers: {
          'Content-Type':
              'multipart/form-data', // Set content type for multipart request
          "Authorization": "Bearer $token"
        }, preserveHeaderCase: true),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
      } else {
        throw Exception("Impossible de booster l'annonce");
      }
    } catch (e) {
      throw Exception("Impossible de booster l'annonce");
    }
  }

  // Fetch all favorite ads for the current user
  Future<List<AdModel>> getMyFavoriteAds() async {
    try {
      // Retrieve the token from local storage
      final token = GetStorage().read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      // Send the GET request to fetch favorite ads
      final response = await dio.get(
        ApiLinkNames.myFavAds, // Replace with your API endpoint
        options: Options(headers: {
          'Authorization': 'Bearer $token', // Include the Bearer token
        }, preserveHeaderCase: true),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response data into a list of AdModel
        final List<dynamic> data = response.data['data'];
        final List<AdModel> favoriteAds =
            data.map((json) => AdModel.fromJson(json)).toList();
        return favoriteAds;
      } else {
        throw Exception("Impossible de récupérer les annonces favorites");
      }
    } catch (e) {
      throw Exception("Impossible de récupérer les annonces favorites");
    }
  }

  // Like an ad
  Future<void> likeAd(int adId) async {
    try {
      // Retrieve the token from local storage
      final token = GetStorage().read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      // Send the POST request to like the ad
      final response = await dio.put(
        '${ApiLinkNames.likeAd}/$adId', // Replace with your API endpoint
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Include the Bearer token
          },
          preserveHeaderCase: true,
        ),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
      } else {
        throw Exception("Impossible d'aimer l'annonce");
      }
    } catch (e) {
      throw Exception("Impossible d'aimer l'annonce");
    }
  }

  Future<File> downloadImage(String imageUrl) async {
    final tempDir =
        await getTemporaryDirectory(); // Get the temporary directory
    final filePath = '${tempDir.path}/image.jpg'; // Define the file path

    // Download the image
    await dio.download(imageUrl, filePath);
    return File(filePath); // Return the downloaded file
  }

  int? getMemberIdFromToken() {
    final token =
        GetStorage().read('token'); // Retrieve the token from local storage
    if (token == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) throw Exception('Invalid token');

      final payload = parts[1];
      final decodedPayload =
          utf8.decode(base64Url.decode(base64Url.normalize(payload)));
      final payloadMap = jsonDecode(decodedPayload);

      return payloadMap['sub']; // Extract 'sub' field as idMember
    } catch (e) {
      return null;
    }
  }
}
