import 'dart:io';
import 'package:afrahdz/core/constants/api.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();

  Future<String?> signupClient(String name, String age, String wilaya,
      String email, String password, String phone, File? image) async {
    List<String> errorMessages = [];

    try {
      final formData = FormData.fromMap({
        'name': name,
        'wilaya': wilaya,
        'age': age.toString(),
        'email': email,
        'phone': phone,
        'password': password,
        'image': await MultipartFile.fromFile(image!.path,
            filename: image.path.split('/').last),
      });

      final response = await dio.post(
        ApiLinkNames.signupclient,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['status'] == 'success') {
          return data['token']; // Return the token
        } else {
          // Handle validation errors
          var errors = data['message'];
          if (errors is Map<String, dynamic>) {
            // Convert the errors map to a list of error messages
            errors.forEach((key, value) {
              if (value is List) {
                errorMessages.addAll(value.map((e) => '$key: $e').toList());
              } else {
                errorMessages.add('$key: $value');
              }
            });

            // Throw the first error message
            if (errorMessages.isNotEmpty) {
              throw errorMessages.first;
            }
          }
          throw Exception('Unknown validation error');
        }
      } else {
        throw Exception('Failed to sign up: ${response.statusCode}');
      }
    } catch (e) {
      Exception(errorMessages.first);
    }
    return null;
  }

  Future<String?> signupMember(
      String name,
      String email,
      String wilaya,
      String location,
      String phone,
      String mobile,
      String password,
      File? image) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'wilaya': wilaya,
        'location': location,
        'phone': phone,
        'mobail': mobile,
        'password': password,
        'image': await MultipartFile.fromFile(image!.path,
            filename: image.path.split('/').last),
      });

      final response = await dio.post(
        ApiLinkNames.signupmember,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        final data = response.data;

        if (data['status'] == 'success') {
          return data['token']; // Return the token
        } else {
          // Handle validation errors
          var errors = data['message'];
          if (errors is Map<String, dynamic>) {
            // Convert the errors map to a list of error messages
            List<String> errorMessages = [];
            errors.forEach((key, value) {
              if (value is List) {
                errorMessages.addAll(value.map((e) => '$key: $e').toList());
              } else {
                errorMessages.add('$key: $value');
              }
            });

            // Throw the first error message
            if (errorMessages.isNotEmpty) {
              throw errorMessages.first;
            }
          }
          throw Exception('Unknown validation error');
        }
      } else {
        throw Exception('Failed to sign up: ${response.statusCode}');
      }
    } catch (e) {
      rethrow; // Rethrow the error to handle it in the controller
    }
  }

  // Login method
  Future<String?> loginClient(String email, String password) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await dio.post(
        ApiLinkNames.loginclient,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        final data = response.data;

        if (data['status'] == 'success') {
          return data['token']; // Return the token
        } else {
          // Handle validation errors
          var errors = data['message'];
          throw Exception('Unknown client validation error : $errors');
        }
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  // Login method
  Future<String?> loginMember(String email, String password) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await dio.post(
        ApiLinkNames.loginmember,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        final data = response.data;

        if (data['status'] == 'success') {
          return data['token']; // Return the token
        } else {
          // Handle validation errors
          var errors = data['message'];
          throw Exception('Unknown member validation error : $errors');
        }
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      rethrow; // Rethrow the error to handle it in the controller
    }
  }

  // Function to send OTP to email using multipart request
  Future<int> sendOtpToEmailClient(String email) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
      });

      final response = await dio.post(
        ApiLinkNames.sendOTPClient,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          return responseData['data'] as int;
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Email not found');
      }
    } catch (e) {
      throw Exception('Email not found');
    }
  }

  // Function to send OTP to email using multipart request
  Future<int> sendOtpToEmailMember(String email) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
      });

      final response = await dio.post(
        ApiLinkNames.sendOTPMembre,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          return responseData['data'] as int;
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Email not found');
      }
    } catch (e) {
      throw Exception('Email not found');
    }
  }

  // Function to reset the password
  Future<bool> resetPasswordClient(String email, String newpassword) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': newpassword,
      });

      final response = await dio.post(
        ApiLinkNames.resetPasswordClient,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          return true;
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<bool> resetPasswordMember(String email, String newpassword) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': newpassword,
      });

      final response = await dio.post(
        ApiLinkNames.resetPasswordMember,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          return true;
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  // Function to update a user with JSON payload
  Future<void> updateClient({
    required int clientId,
    required String name,
    required String wilaya,
    required String phone,
  }) async {
    try {
      // Retrieve the JWT token from local storage
      final String? token = storage.read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      final Map<String, dynamic> payload = {
        'name': name,
        'wilaya': wilaya,
        'phone': phone,
      };

      await dio.put(
        '${ApiLinkNames.editClient}/$clientId',
        data: payload,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }, preserveHeaderCase: true),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse['errors'] != null) {
          final errors = errorResponse['errors'] as Map<String, dynamic>;
          errors.forEach((field, messages) {});
        }
      } else {
        throw Exception("Error while updating client");
      }
    }
  }

  // Function to update a user with JSON payload
  Future<void> updateMembre({
    required int membreId,
    required String name,
    required String wilaya,
    required String phone,
    required String fixe,
  }) async {
    try {
      // Retrieve the JWT token from local storage
      final String? token = storage.read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      final Map<String, dynamic> payload = {
        if (name.isNotEmpty) "name": name,
        if (wilaya.isNotEmpty) 'wilaya': wilaya,
        if (phone.isNotEmpty) 'mobail': phone,
        if (fixe.isNotEmpty) 'phone': fixe,
      };

      await dio.put(
        '${ApiLinkNames.editMember}/$membreId',
        data: payload,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }, preserveHeaderCase: true),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse['errors'] != null) {
          final errors = errorResponse['errors'] as Map<String, dynamic>;
          errors.forEach((field, messages) {});
        }
      } else {
        throw Exception("Error while updating membre");
      }
    }
  }
}
