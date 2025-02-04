import 'dart:typed_data';
import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get_storage/get_storage.dart';

class HomepageService {
  final GetStorage storage = GetStorage();
  final Dio dio = Dio();

  // Function to get userID from the token
  int? getUserIdFromToken() {
    final token = storage.read('token');
    if (token != null) {
      try {
        final decodedToken = JwtDecoder.decode(token);
        return decodedToken['sub']; // Extract userID from the token
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Function to fetch user details using userID
  Future<UserModel?> fetchClientDetails(int userId) async {
    final url = '${ApiLinkNames.getClientInfo}/$userId'; // Replace with your API URL
    final profilePictureUrl = '${ApiLinkNames.getClientInfo}/image/$userId'; // Replace with your API URL

    try {
      // Fetch user details
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer ${storage.read('token')}',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'success') {
          final user = UserModel.fromJson(data['data']); // Return UserModel

          // Fetch profile picture
          final profilePictureResponse = await dio.get(
            profilePictureUrl,
            options: Options(
              headers: {
                'Authorization': 'Bearer ${storage.read('token')}',
              },
              preserveHeaderCase: true,
              responseType: ResponseType.bytes, // Get response as bytes
            ),
          );

          if (profilePictureResponse.statusCode == 200) {
            final profilePictureBytes = profilePictureResponse.data as Uint8List;
            return UserModel(
              id: user.id,
              name: user.name,
              email: user.email,
              wilaya: user.wilaya,
              phone: user.phone,
              profilePicture: profilePictureBytes, // Add profile picture
            );
          } else {
            // If profile picture fails, return user details without the picture
            return user;
          }
        } else {
          throw Exception(data['message'] ?? "Impossible de récupérer les détails de l'utilisateur");
        }
      } else {
        throw Exception("Impossible de récupérer les détails de l'utilisateur");
      }
    } catch (e) {
      throw Exception("Quelque chose s'est mal passé");
    }
  }

  // Function to fetch user details using userID
  Future<UserModel?> fetchMemberDetails(int userId) async {
    final url = '${ApiLinkNames.getMemberInfo}/$userId'; // Replace with your API URL
    final profilePictureUrl = '${ApiLinkNames.getMemberInfo}/image/$userId'; // Replace with your API URL

    try {
      // Fetch user details
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer ${storage.read('token')}',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'success') {
          final user = UserModel.fromJson(data['data']); // Return UserModel

          // Fetch profile picture
          final profilePictureResponse = await dio.get(
            profilePictureUrl,
            options: Options(
              headers: {
                'Authorization': 'Bearer ${storage.read('token')}',
              },
              preserveHeaderCase: true,

              responseType: ResponseType.bytes, // Get response as bytes
            ),
          );

          if (profilePictureResponse.statusCode == 200) {
            final profilePictureBytes = profilePictureResponse.data as Uint8List;
            return UserModel(
              id: user.id,
              name: user.name,
              email: user.email,
              wilaya: user.wilaya,
              phone: user.phone,
              fixe: user.fixe,
              profilePicture: profilePictureBytes, // Add profile picture
            );
          } else {
            // If profile picture fails, return user details without the picture
            return user;
          }
        } else {
          throw Exception(data['message'] ?? "Quelque chose s'est mal passé");
        }
      } else {
        throw Exception("Impossible de récupérer les détails de l'utilisateur");
      }
    } catch (e) {
      throw Exception("Quelque chose s'est mal passé");
    }
  }

  // Function to get userID and fetch user details
  Future<UserModel?> getUserDetails(bool isMember) async {
    final userId = getUserIdFromToken();

    if (userId != null && isMember) {
      return await fetchMemberDetails(userId);
    } else if (userId != null && !isMember) {
      return await fetchClientDetails(userId);
    } else {
      return null;
    }
  }
}