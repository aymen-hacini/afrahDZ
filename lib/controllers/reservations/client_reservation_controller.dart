import 'package:afrahdz/core/services/reservation_service.dart';
import 'package:afrahdz/data/models/full_ad_details.dart';
import 'package:afrahdz/data/models/reservation.dart';
import 'package:get/get.dart';

class ClientReservationController extends GetxController {
  final ReservationService reservationService = ReservationService();
  final RxList<ReservationModel> reservations = <ReservationModel>[].obs;
  final RxBool isLoading = false.obs;
  var selectedAdDetails = FullAdDetails(
    id: 0,
    name: '',
    category: '',
    eventType: '',
    city: '',
    address: '',
    creationDate: '',
    mobile: '',
    price: 0,
    visits: 0,
    likes: 0,
    idmobmre: 0,
    imageFullPath: '',
    videoFullPath: '',
    boost: {},
    images: [],
    actions: [],
    allowed: false,
    liked: false
  ).obs;

  Future<void> fetchReservations() async {
    isLoading(true);
    try {
      final fetchedReservations =
          await reservationService.fetchReservationsWithAdDetails();
      reservations.assignAll(fetchedReservations);
    } finally {
      isLoading(false);
    }
  }

  // Method to delete a reservation
  void deleteReservation(ReservationModel reservation) async {
    try {
      // Call the service to delete the reservation from the server
      final isDeleted =
          await reservationService.deleteReservation(reservation.id);

      if (isDeleted) {
        // Remove the reservation from the appropriate list based on its status
        reservations.remove(reservation);
        Get.back();

        Get.snackbar('Success', 'Réservation supprimée avec succès');
      } else {
        Get.snackbar('Erreur', 'Impossible de supprimer la réservation');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de supprimer la réservation');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchReservations();
  }
}
