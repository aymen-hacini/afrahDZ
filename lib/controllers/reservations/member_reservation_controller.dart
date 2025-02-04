import 'dart:typed_data';

import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/services/homepage_service.dart';
import 'package:afrahdz/core/services/reservation_service.dart';
import 'package:afrahdz/data/models/reservation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberReservationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final tabIndex = 0.obs;
  final ReservationService reservationService = ReservationService();
  final HomepageService homepageService = HomepageService();
  final RxList<ReservationModel> reservationsEnattente =
      <ReservationModel>[].obs;
  final RxList<ReservationModel> reservationsValide = <ReservationModel>[].obs;
  final RxList<ReservationModel> reservationsAnnuler = <ReservationModel>[].obs;
  final RxList<ReservationModel> allReservations = <ReservationModel>[].obs;
  final RxBool isLoading = false.obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    fetchReservations();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> fetchReservations() async {
    isLoading(true);
    try {
      // Fetch reservations with ad details
      final fetchedReservations =
          await reservationService.fetchReservationsWithAdDetails();

      // Clear existing lists
      reservationsEnattente.clear();
      reservationsValide.clear();
      reservationsAnnuler.clear();
      allReservations.clear();

      // Categorize reservations based on 'etat'
      for (var reservation in fetchedReservations) {
        final clientImage = await getImageById(reservation.idClient.toString());
        reservation.imageBytes = clientImage;
        if (reservation.etat == 'attente') {
          reservationsEnattente.add(reservation);
        } else if (reservation.etat == 'active') {
          reservationsValide.add(reservation);
        } else if (reservation.etat == "inactive") {
          reservationsAnnuler.add(reservation);
        }
      }

      // Optionally, assign all fetched reservations to the main list
      allReservations.assignAll(fetchedReservations);
    } finally {
      isLoading(false);
    }
  }

  // Method to move a reservation from "en attente" to "validé"
  void moveReservationToValide(ReservationModel reservation) async {
    await reservationService.updateReservation(
        reservationId: reservation.id, etat: "active");

    // Remove the reservation from the "en attente" list
    reservationsEnattente.remove(reservation);

    // Update the reservation's status to "active"
    reservation.etat = 'active';

    // Add the reservation to the "validé" list
    reservationsValide.add(reservation);

    // Notify the UI that the lists have been updated
    update();
  }

  // Method to move a reservation from "en attente" to "validé"
  void moveReservationToAnnuler(ReservationModel reservation) async {
    await reservationService.updateReservation(
        reservationId: reservation.id, etat: "inactive");

    // Remove the reservation from the "en attente" list
    reservationsEnattente.remove(reservation);

    // Update the reservation's status to "active"
    reservation.etat = 'inactive';

    // Add the reservation to the "validé" list
    reservationsAnnuler.add(reservation);

    // Notify the UI that the lists have been updated
    update();
  }

  Future<Uint8List> getImageById(String id) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        '${ApiLinkNames.getClientInfo}/image/$id',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data);
      } else {
        throw Exception("Impossible de charger l'image");
      }
    } catch (e) {
      throw Exception("Impossible de charger l'image");
    }
  }
}
