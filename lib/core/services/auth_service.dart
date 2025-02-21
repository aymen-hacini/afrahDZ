import 'dart:io';
import 'package:afrahdz/core/constants/api.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();

  // Future<String?> signupClient(
  //     String name,
  //     String age,
  //     String wilaya,
  //     String email,
  //     String password,
  //     String phone,
  //     File? image,
  //     String deviceToken) async {
  //   List<String> errorMessages = [];

  //   try {
  //     final formData = FormData.fromMap({
  //       'name': name,
  //       'wilaya': wilaya,
  //       'age': age.toString(),
  //       'email': email,
  //       "fcm": deviceToken,
  //       'phone': phone,
  //       'password': password,
  //       'image': await MultipartFile.fromFile(image!.path,
  //           filename: image.path.split('/').last),
  //     });

  //     dio.interceptors.add(InterceptorsWrapper(
  //       onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
  //         // Do something before the request is sent
  //         print('Request Interceptor: Sending request to ${options.uri}');

  //         // You can modify the request options here
  //         options.headers['Authorization'] = 'Bearer your_token_here';

  //         // Continue with the request
  //         return handler.next(options);
  //       },
  //       onResponse: (Response response, ResponseInterceptorHandler handler) {
  //         // Do something with the response
  //         print(
  //             'Response Interceptor: Received response with status ${response.data}');

  //         // Continue with the response
  //         return handler.next(response);
  //       },
  //       onError: (DioException error, ErrorInterceptorHandler handler) {
  //         // Do something with the error
  //         print('Error Interceptor: Error occurred - ${error.message}');

  //         // Continue with the error
  //         return handler.next(error);
  //       },
  //     ));
  //     final response = await dio.post(
  //       ApiLinkNames.signupclient,
  //       data: formData,
  //     );

  //     print(response.statusCode);
  //     print(response.data);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = response.data;

  //       if (data['status'] == 'success') {
  //         return data['token']; // Return the token
  //       } else {
  //         // Handle validation errors
  //         var errors = data['message'];
  //         if (errors is Map<String, dynamic>) {
  //           // Convert the errors map to a list of error messages
  //           errors.forEach((key, value) {
  //             if (value is List) {
  //               errorMessages.addAll(value.map((e) => '$key: $e').toList());
  //             } else {
  //               errorMessages.add('$key: $value');
  //             }
  //           });

  //           // Throw the first error message
  //           if (errorMessages.isNotEmpty) {
  //             print(response.statusCode);
  //             print(response.data);
  //             throw errorMessages.first;
  //           }
  //         }
  //         print(response.statusCode);
  //         print(response.data);
  //         throw Exception('Unknown validation error');
  //       }
  //     } else {
  //       print(response.statusCode);
  //       print(response.data);
  //       throw Exception('Failed to sign up: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     Exception(errorMessages.first);
  //   }
  //   return null;
  // }

  Future<String?> signupClient(
    String name,
    String age,
    String wilaya,
    String email,
    String password,
    String phone,
    File? image,
    String deviceToken,
  ) async {
    List<String> errorMessages = [];

    // Create a Dio instance
    Dio dio = Dio();

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Log the request URL, method, and body
        print('Request URL: ${options.uri}');
        print('Request Method: ${options.method}');
        print('Request Headers: ${options.headers}');
        print('Request Body: ${options.data}');

        // Continue with the request
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Log the response status code and data
        print('Response Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');

        // Continue with the response
        handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        // Log the error details
        print('Error: ${error.message}');
        print('Error Status Code: ${error.response?.statusCode}');
        print('Error Response Data: ${error.response?.data}');

        // Handle HTTP 422 errors specifically
        if (error.response?.statusCode == 422) {
          // Parse validation errors from the response
          final responseData = error.response?.data;
          if (responseData != null && responseData is Map<String, dynamic>) {
            final errors = responseData['errors'] ?? responseData['message'];
            if (errors is Map<String, dynamic>) {
              errors.forEach((key, value) {
                if (value is List) {
                  errorMessages.addAll(value.map((e) => '$key: $e').toList());
                } else {
                  errorMessages.add('$key: $value');
                }
              });
            }
          }
        }

        // Continue with the error
        handler.next(error);
      },
    ));

    try {
      final formData = FormData.fromMap({
        'name': name,
        'wilaya': wilaya,
        'age': age.toString(),
        'email': email,
        "fcm": deviceToken,
        'phone': phone,
        'password': password,
        'image': image != null
            ? await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last)
            : null,
      });

      final response = await dio.post(
        ApiLinkNames.signupclient,
        data: formData,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

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
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., HTTP 422)
      if (e.response?.statusCode == 422) {
        // Use the error messages already parsed in the interceptor
        if (errorMessages.isNotEmpty) {
          throw errorMessages.first;
        } else {
          throw Exception('Validation error: ${e.response?.data}');
        }
      } else {
        // Handle other Dio errors
        throw Exception('Dio error: ${e.message}');
      }
    } catch (e) {
      // Handle generic exceptions
      throw Exception('An error occurred: $e');
    }
  }

  Future<String?> signupMember(
    String name,
    String email,
    String wilaya,
    String location,
    String phone,
    String mobile,
    String password,
    File? image,
    String deviceToken,
  ) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'wilaya': wilaya,
        'location': location,
        'phone': phone,
        "fcm": deviceToken,
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
  Future<String?> loginClient(
      String email, String password, String deviceToken) async {
    try {
      final formData = FormData.fromMap(
          {'email': email, 'password': password, "fcm": deviceToken});

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
  Future<String?> loginMember(
      String email, String password, String deviceToken) async {
    try {
      final formData = FormData.fromMap(
          {'email': email, 'password': password, "fcm": deviceToken});

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
