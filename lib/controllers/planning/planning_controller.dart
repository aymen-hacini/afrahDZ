
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/services/reservation_service.dart';
import 'package:afrahdz/data/models/planning.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlanningController extends GetxController {
  DateTime? beginselectedDate;
  DateTime? endselectedDate;

  final RxList<PlanningModel> plannings = <PlanningModel>[].obs;
  final ReservationService reservationService = ReservationService();
  final dio = Dio();

  final RxBool isLoading = false.obs;

  Future<void> selectBeginDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: beginselectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Appcolors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Calendar background color
              onSurface: Colors.black, // Calendar text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != beginselectedDate) {
      beginselectedDate = picked;
      update();
    } else if (picked == null) {
      endselectedDate = DateTime.now();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endselectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Appcolors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Calendar background color
              onSurface: Colors.black, // Calendar text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != endselectedDate) {
      endselectedDate = picked;
      update();
    } else if (picked == null) {
      endselectedDate = DateTime.now();
    }
  }

  Future<void> fetchReservationswithDateRange() async {
    try {
      // Fetch plannings with ad details
      isLoading(true);

      final formattedStartdate =
          DateFormat('yyyy-MM-dd').format(beginselectedDate!);
      final formattedEndDate =
          DateFormat('yyyy-MM-dd').format(endselectedDate!);

      final fetchedPlannings = await reservationService
          .fetchReservationsWithDateRange(formattedStartdate, formattedEndDate);

      // Clear existing lists
      plannings.clear();
      // Categorize reservations based on 'etat'
      

      // Optionally, assign all fetched reservations to the main list
      plannings.assignAll(fetchedPlannings);
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de récupérer les réservations');
    } finally {
      isLoading(false);
    }
  }

}
