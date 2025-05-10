import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:get/get.dart';

class TopadsController  extends GetxController{
    final AdService adService = AdService();
      var topAds = <AdModel>[].obs; // Observable list of vip ads

       final RxBool isLoading = false.obs;
  int currentPage = 1;
  bool hasMore = true;
    String? topAdsSelectedWilaya;

    



    // Function to fetch vip ads
  Future<void> fetchTopAds({String wilaya = ''}) async {
    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.getVipAds(
        page: currentPage,
        wilaya: wilaya,
      ); // Call AdService to fetch ads
      topAds.value = fetchedAds; // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces Gold');
    } finally {
      isLoading(false); // Set loading to false
    }
  }


     // Function to fetch vip ads
  Future<void> fetchTopAdswithNextpage({String wilaya = ''}) async {
    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.getVipAds(
          page: currentPage,wilaya: wilaya); // Call AdService to fetch ads
      topAds.value = fetchedAds; // Update the observable list
      currentPage++;
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces Gold');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTopAds(); // Fetch vip ads when the controller is initialized
  }

}