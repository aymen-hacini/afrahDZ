import 'dart:typed_data';

import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/data/models/planning.dart';
import 'package:afrahdz/data/models/reservation.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ReservationService {
  final GetStorage storage = GetStorage();
  final AdService adService = AdService();
  final dio = Dio(); // Initialize Dio instance

  Future<void> createReservation({
    required String reservationDate,
    required String finalReservationDate,
    required String name,
    required String email,
    required String phone,
    required String type,
    required String date,
    required String idMember,
    required String idAnnonce,
    required String idClient,
  }) async {
    final url =
        ApiLinkNames.createReservation; // Replace with your API endpoint

    try {
      final token = storage.read('token'); // Retrieve the token from storage
      if (token == null || token.isEmpty) {
        throw Exception('Token is missing. Please log in again.');
      }

      // Create FormData for multipart/form-data
      final formData = FormData.fromMap({
        'reservationDate': reservationDate,
        'finalreservationDate': finalReservationDate,
        'name': name,
        'email': email,
        'phone': phone,
        'type': type,
        'date': date,
        'idMember': idMember,
        'idAnnonce': idAnnonce,
        'idClient': idClient,
      });

      // Add built-in LogInterceptor
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));

      // Send the request using Dio
      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type':
              'multipart/form-data', // Set content type for multipart request
        }, preserveHeaderCase: true),
      );

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception("Échec de la création de la réservation");
      }
    } catch (e) {
      throw Exception("Échec de la création de la réservation");
    }
  }

  // Function to fetch all reservations with ad details
  Future<List<ReservationModel>> fetchReservationsWithAdDetails() async {
    var token = storage.read("token");
    final headers = {'Authorization': 'Bearer $token'};

    // Add LogInterceptor to Dio
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    try {
      // Send the GET request using Dio
      final response = await dio.get(
        ApiLinkNames.getmyreservations,
        options: Options(headers: headers, preserveHeaderCase: true),
      );
      // Print response for debugging

      if (response.statusCode == 200) {
        // Access the data directly from response.data
        final List<dynamic> reservationsData = response.data['data'];
        final List<ReservationModel> reservations = reservationsData
            .map((json) => ReservationModel.fromJson(json))
            .toList();

        // Fetch ad details for each reservation
        for (var reservation in reservations) {
          try {
            final fetchedadDetails =
                await adService.getFullAdDetails(reservation.idAnnonce);
            reservation.adDetails = fetchedadDetails;
            // Assign the FullAdDetails object
          } catch (e) {
            throw Exception(e);
          }
        }

        return reservations;
      } else {
        throw Exception('Impossible de récupérer les réservations');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les réservations');
    }
  }

  // Function to fetch all reservations with ad details
  Future<List<PlanningModel>> fetchReservationsWithDateRange(
      String beginDate, String endDate) async {
    var token = storage.read("token");
    final headers = {'Authorization': 'Bearer $token'};
    final decodedToken = JwtDecoder.decode(token);

    // Verify headers here

    // Add LogInterceptor to Dio
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    try {
      // Send the GET request using Dio
      final response = await dio.get(
        "${ApiLinkNames.getMyplanning}?FinalDate=$endDate&StartDate=$beginDate",
        options: Options(headers: headers, preserveHeaderCase: true),
      );
      // Print response for debugging

      if (response.statusCode == 200) {
        // Access the data directly from response.data
        final List<dynamic> reservationsData = response.data['data'];
        final List<PlanningModel> reservations = reservationsData
            .map((json) =>
                PlanningModel.fromJson(json, userRole: decodedToken['role']))
            .toList();
        for (var reservation in reservations) {
          final userImage = decodedToken['role'] == "client"
              ? await getMembreimagebyId(reservation.membre.id.toString())
              : await getClientImageById(reservation.membre.id.toString());
          reservation.membre.profilePicture = userImage;
        }

        return reservations;
      } else {
        throw Exception('Impossible de récupérer les réservations');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les réservations');
    }
  }

  // Function to update a user with JSON payload
  Future<void> updateReservation(
      {required int reservationId, required String etat}) async {
    try {
      // Retrieve the JWT token from local storage
      final String? token = storage.read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      // Prepare the JSON payload
      final Map<String, dynamic> payload = {
        'etat': etat,
      };

      // Send the PUT request to update the ad
      await dio.put(
        '${ApiLinkNames.updateReservation}/$reservationId', // Replace with your API endpoint
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

  // Method to delete a reservation
  Future<bool> deleteReservation(int reservationId) async {
    try {
      // Retrieve the JWT token from local storage
      final token = GetStorage().read('token');
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }
      final response =
          await dio.delete('${ApiLinkNames.deleteReservation}/$reservationId',
              options: Options(headers: {
                "Authorization": "Bearer $token",
              }, preserveHeaderCase: true));

      if (response.statusCode == 200) {
        return true; // Deletion successful
      } else {
        return false; // Deletion failed
      }
    } catch (e) {
      return false; // Deletion failed
    }
  }

  Future<Uint8List> getClientImageById(String id) async {
    try {
      final response = await dio.get(
        '${ApiLinkNames.getClientInfo}/image/$id',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Uint8List.fromList(response.data);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Failed to load image: $e');
    }
  }

  Future<Uint8List> getMembreimagebyId(String id) async {
    try {
      final response = await dio.get(
        '${ApiLinkNames.getMemberInfo}/image/$id',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Uint8List.fromList(response.data);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Failed to load image: $e');
    }
  }
}
