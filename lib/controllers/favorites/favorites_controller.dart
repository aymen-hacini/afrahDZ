import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final AdService adService = AdService();

  // Observable list of favorite ads
  final favoriteAds = <AdModel>[].obs;

  // Observable loading state
  final isLoading = false.obs;

  // Fetch all favorite ads
  Future<void> fetchMyFavoriteAds() async {
    isLoading(true);
    favoriteAds.clear();
    try {
      final fetchedFavoriteAds = await adService.getMyFavoriteAds();
      favoriteAds.assignAll(fetchedFavoriteAds);
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de récupérer les annonces favorites');
    } finally {
      isLoading(false);
    }
  }

  // unLike an ad and remove it from favorites
  Future<void> likeAd(int adId) async {
    try {
      await adService.likeAd(adId);
      favoriteAds.removeWhere((ad) => ad.id == adId);
    } catch (e) {
      Get.snackbar('Erreur', "Impossible de supprimer l'annonce");
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyFavoriteAds();
  }
}
