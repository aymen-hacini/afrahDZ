import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/core/services/categorie_service.dart';
import 'package:afrahdz/core/services/homepage_service.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:afrahdz/data/models/user.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:afrahdz/views/screens/homepage/homepage_allproducts.dart';
import 'package:afrahdz/views/widgets/homepage/location_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomepageService homepageService = HomepageService();
  final AdService adService = AdService();
  final CategorieService categoryService = CategorieService();
  final categories = <CategorieModel>[].obs;
  final GetStorage storage = GetStorage();

  final RefreshController refreshController = RefreshController();

  final Rx<UserModel?> userDetails = Rx<UserModel?>(null);
  var vipAds = <AdModel>[].obs; // Observable list of vip ads
  var vipAdsfilter = <AdModel>[].obs; // Observable list of vip ads
  var goldAds = <AdModel>[].obs; // Observable list of gold ads
  var normalAds = <AdModel>[].obs; // Observable list of normal ads

  final RxBool isLoading = false.obs;
  int currentPage = 1;
  bool hasMore = true;

  RxString selectedWilaya = ''.obs;
  RxString selectedFete = ''.obs;
  RxString topAdsSelectedWilaya = ''.obs;
  String? selectedCat;

  // AnimationController to manage the animation
  late AnimationController animationController;
  late Animation<double> animation;

  final ScrollController scrollController = ScrollController();
  final RxDouble carouselScale = 1.0.obs;
  final RxDouble carouselOpacity = 1.0.obs;

  // Observable current page index
  final RxInt currentPageIndex = 0.obs;

  late bool isMemberLoggedIn;

  @override
  void onInit() {
    _checkInternetConnection();

    super.onInit();
    print(userDetails.value);

    // Initialize the AnimationController
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Animation duration
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  Future<void> onRefresh() async {
    try {
      // Your refresh logic here
      await fetchUserDetails();
      await fetchVipAds();
      await fetchCategories();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  // Method to start the animation

  void updatePageIndex(int index) {
    currentPageIndex.value = index; // Update the current page index
  }

  void _onScroll() {
    final offset = scrollController.offset;
    // Adjust the scale based on scroll offset
    carouselScale.value = (offset > 0) ? 1.0 - (offset / 1200) : 1.0;
    carouselOpacity.value = (offset > 0) ? 1.0 - (offset / 1200) : 1.0;

    // Clamp the scale between 0.5 and 1.0
    carouselScale.value = carouselScale.value.clamp(0.3, 1.0);
    carouselOpacity.value = carouselOpacity.value.clamp(0.0, 1.0);
  }

  Future<void> fetchUserDetails() async {
    try {
      final user = await homepageService.getUserDetails(isMemberLoggedIn);
      if (user != null) {
        userDetails.value = user;
        update();
      }
    } catch (e) {
      throw Exception();
    }
    Get.forceAppUpdate();
  }

  // Function to fetch vip ads
  Future<void> fetchVipAds() async {
    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.getVipAds(
        page: currentPage,
      ); // Call AdService to fetch ads
      vipAds.value = fetchedAds; // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces Gold');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Function to fetch vip ads
  Future<void> fetchVipAdswithNextpage() async {
    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.getVipAds(
          page: currentPage); // Call AdService to fetch ads
      vipAds.value = fetchedAds; // Update the observable list
      currentPage++;
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces Gold');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Function to fetch vip ads
  Future<void> fetchSpecificVipAds(
      String location, String cat, String fete) async {
    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.getVipAdswithFilter(
          location, cat, fete,
          page: currentPage); // Call AdService to fetch ads
      vipAdsfilter.value = fetchedAds; // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces Gold');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Function to fetch vip ads
  Future<void> fetchSpecificVipAdswithNextpage(
      String location, String cat, String fete) async {
    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.getVipAdswithFilter(
          location, cat, fete,
          page: currentPage); // Call AdService to fetch ads
      vipAdsfilter.value = fetchedAds; // Update the observable list
      currentPage++;
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces Gold');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Function to fetch gold ads
  Future<void> fetchGoldads(String location, String cat, String fete) async {
    if (goldAds.isNotEmpty) {
      return;
    } else {
      try {
        isLoading(true); // Set loading to true
        final fetchedAds = await adService.getGoldads(location, cat, fete,
            page: currentPage); // Call AdService to fetch ads
        goldAds.value = fetchedAds; // Update the observable list
      } catch (e) {
        Get.snackbar('Erreur', 'Impossible de récupérer les annonces');
      } finally {
        isLoading(false); // Set loading to false
      }
    }
  }

  // Function to fetch gold ads
  Future<void> fetchGoldadswithNextpage(
      String location, String cat, String fete) async {
    if (goldAds.isNotEmpty) {
      return;
    } else {
      try {
        isLoading(true); // Set loading to true
        final fetchedAds = await adService.getGoldads(location, cat, fete,
            page: currentPage); // Call AdService to fetch ads
        goldAds.value = fetchedAds; // Update the observable list
        currentPage++;
      } catch (e) {
        Get.snackbar('Erreur', 'Impossible de récupérer les annonces');
      } finally {
        isLoading(false); // Set loading to false
      }
    }
  }

  // Function to fetch normal ads
  Future<void> fetchNormalads(
      String location, String catname, String fete) async {
    normalAds.clear();
    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.getNormalads(
          location, catname, fete); // Call AdService to fetch ads
      normalAds.value = fetchedAds; // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces normales');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Function to fetch normal ads
  Future<void> searchByname(String adname, String catname) async {
    normalAds.clear();

    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService.searchAdsbyName(
          adname, selectedWilaya.value, catname); // Call AdService to fetch ads
      normalAds.value = fetchedAds; // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces normales');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Function to fetch normal ads
  Future<void> searchinAllCats(String adname) async {
    normalAds.clear();

    try {
      isLoading(true); // Set loading to true
      final fetchedAds = await adService
          .searchAdsinAllCats(adname); // Call AdService to fetch ads
      normalAds.value = fetchedAds; // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces normales');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  void logout() {
    // Clear saved credentials if "Remember Me" is unchecked
    storage.remove('email');
    storage.remove('password');
    storage.remove('userType');
    storage.remove('token');
    storage.write('rememberMe',false);
    Get.offAllNamed(AppRoutesNames.homepage, arguments: {"isMember": false});
  }

  // Observable list of categories

  // Observable loading state

  // Fetch categories
  Future<void> fetchCategories() async {
    isLoading(true);
    try {
      final fetchedCategories = await categoryService.fetchAllCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    } finally {
      isLoading(false);
    }
  }

  // Function to launch URLs
  Future<void> launchCustomUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void showLocationpicker(String categoryname) {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      persistent: false,
      Container(
        height: AppSize.appheight * .5,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "choosewilaya".tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.63,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .02,
            ),
            LocationPicker(),
            SizedBox(
              height: AppSize.appheight * .02,
            ),
            Text(
              'chooseEvent'.tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.63,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .02,
            ),
            EventPicker(),
            SizedBox(
              height: AppSize.appheight * .06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shadowColor: Colors.black, // Remove default shadow
                        elevation: 4),
                    onPressed: () {
                      Get.back();
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSize.appheight * .02,
                          horizontal: AppSize.appwidth * .13),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        'Cancelbtn'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shadowColor: Colors.black, // Remove default shadow
                        elevation: 4),
                    onPressed: () {
                      Get.back();
                      goldAds.clear();
                      fetchGoldads(selectedWilaya.value, selectedCat ?? "",
                          selectedFete.value);
                      fetchNormalads(selectedWilaya.value, categoryname,
                          selectedFete.value);

                      selectedWilaya.isEmpty
                          ? fetchVipAds()
                          : fetchSpecificVipAds(selectedWilaya.value,
                              categoryname, selectedFete.value);
                      Get.to(
                        () => const HomepageAllproducts(),
                      );
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSize.appheight * .02,
                          horizontal: AppSize.appwidth * .13),
                      decoration: BoxDecoration(
                          gradient: Appcolors.primaryGradient,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(11)),
                      child: isLoading.value
                          ? const CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            )
                          : Text(
                              'Validbtn'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _checkInternetConnection() async {
    bool hasInternet = await InternetConnection().hasInternetAccess;
    if (!hasInternet) {
      Get.offAllNamed('/no-internet');
    } else {
      fetchVipAds();
      fetchCategories();
      if (Get.arguments['isMember'] != null) {
        isMemberLoggedIn = Get.arguments['isMember'];
      }
      scrollController.addListener(_onScroll);
      if (controller.isLoggedIn) {
        fetchUserDetails();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();

    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    refreshController.dispose(); // Dispose SmartRefresher controller

// Dispose the controller
    super.dispose();
  }
}
