import 'package:afrahdz/core/services/reservation_service.dart';
import 'package:afrahdz/data/models/planning.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlanningController extends GetxController {
  final RxList<PlanningModel> plannings = <PlanningModel>[].obs;
  final ReservationService reservationService = ReservationService();
  final dio = Dio();

  final RxBool isLoading = false.obs;

  Future<void> fetchReservationswithDateRange() async {
    try {
      // Fetch plannings with ad details
      isLoading(true);

      final formattedStartdate =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      final formattedEndDate =
          DateFormat('yyyy-MM-dd').format(DateTime(2101, 1, 1));

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

  @override
  void onInit() {
    super.onInit();
    fetchReservationswithDateRange();
  }
}
