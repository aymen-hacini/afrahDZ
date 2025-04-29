import 'package:afrahdz/core/constants/api.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ContactService {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();

  // Function to send a "Contact Us" message using multipart request
  Future<void> sendContactUsMessage({
    required String email,
    required String message,
    required String subject,
    required String phone,
    required String genre,
    required String name,
  }) async {
    try {
      // Retrieve the JWT token from local storage
      final String? token = storage.read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      // Create FormData for the multipart request
      final FormData formData = FormData.fromMap({
        'email': email,
        'message': message,
        'subject': subject,
        'phone': phone,
        'genre': genre,
        'name': name,
      });

      // Send the multipart POST request to the "Contact Us" endpoint
      final Response response = await dio.post(
        ApiLinkNames.contact, // Replace with your API endpoint
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token', // Include the Bearer token
          'Content-Type':
              'multipart/form-data', // Set content type for multipart request
        }, preserveHeaderCase: true),
      );

      // Check if the request was successful
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception("Échec de l'envoi du message");
      }
    }
    catch (e) {
      throw Exception("Échec de l'envoi du message");
    }
  }
}
