import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:get/get.dart';

class MyAnnoncesController extends GetxController {
  final AdService adService = AdService();
  final announces = <AdModel>[].obs;
  final isLoading = false.obs;

  Future<void> fetchAnnounces() async {
    isLoading(true);
    try {
      final fetchedAnnounces = await adService.getMyannonces();
      announces.assignAll(fetchedAnnounces);
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces');
    } finally {
      isLoading(false);
    }
  }

  // Method to delete a reservation
  void deleteAnnonce(AdModel annonce) async {
    try {
      // Call the service to delete the reservation from the server
      final isDeleted = await adService.deleteAnnonce(annonce.id);

      if (isDeleted) {
        // Remove the reservation from the appropriate list based on its status
        announces.remove(annonce);
        Get.back();

        Get.snackbar('Success', 'Annonce supprimée avec succès');
      } else {
        Get.snackbar('Erreur', "Impossible de supprimer l'annonce");
      }
    } catch (e) {
      Get.snackbar('Erreur', "Impossible de supprimer l'annonce");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAnnounces();
  }
}
