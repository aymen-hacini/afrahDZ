import 'dart:ui';

import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:afrahdz/views/widgets/annonces/annonce_popup_picker.dart';
import 'package:afrahdz/views/widgets/annonces/felictation.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  // Define your variables and methods here
  var balance = 0.0.obs; // Example observable variable for wallet balance
  final AdService adService = AdService();
  final announces = <AdModel>[].obs;
  final isLoading = false.obs;
  final selectedAd = Rx<AdModel?>(null);
  late String code;
  late int codeuse;

  void addFunds(double amount) {
    if (amount > 0) {
      balance.value += amount;
    }
  }

  void withdrawFunds(double amount) {
    if (amount > 0 && amount <= balance.value) {
      balance.value -= amount;
    }
  }

  Future<void> boostAdwithPoints() async {
    try {
      isLoading(true);
      await adService.boostAdwithPoints(
        idAnnonce: selectedAd.value!.id,
      );
      Get.back();

      Get.snackbar('Success', 'Annonce boostée avec succès');
      Get.back();
      showFelictations();
    } catch (e) {
      Get.snackbar('Erreur', "Impossible de booster l'annonce");
    } finally {
      isLoading(false);
    }
  }

  showBoostOptions(BuildContext context) {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      persistent: true,
      useRootNavigator: true,
      enableDrag: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(51),
          topRight: Radius.circular(51),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .04),
          height: AppSize.appheight * .4,
          width: AppSize.appwidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: AppSize.appheight * .004,
                  width: AppSize.appwidth * .2,
                  decoration: ShapeDecoration(
                    gradient: Appcolors.primaryGradient,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSize.appheight * .01),
              Center(
                child: Text(
                  "Promote".tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: AppSize.appheight * .03),
              GradientText(
                text: "Offre VIP".tr,
                gradient: Appcolors.primaryGradient,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0.88,
                ),
              ),
              SizedBox(height: AppSize.appheight * .03),
              Text(
                'AdName'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0.88,
                ),
              ),
              SizedBox(height: AppSize.appheight * .01),
              const AnnonceWalletPopupPicker(),
              SizedBox(height: AppSize.appheight * .02),
              Obx(
                () => Center(
                  child: AnimatedContainer(
                    duration: 300.milliseconds,
                    width: isLoading.value
                        ? AppSize.appwidth * .2
                        : AppSize.appwidth * .9,
                    margin: EdgeInsets.only(bottom: AppSize.appheight * .02),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shadowColor: Colors.black,
                        elevation: 4,
                      ),
                      onPressed: () {
                        boostAdwithPoints();
                      },
                      child: Ink(
                        height: AppSize.appheight * .06,
                        decoration: BoxDecoration(
                          gradient: Appcolors.primaryGradient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: isLoading.value
                              ? const CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                )
                              : Text(
                                  'Boost'.tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFFBFBFB),
                                    fontSize: 20,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Update the selected ad
  void updateSelectedAd(AdModel ad) {
    selectedAd.value = ad;
  }

  Future<void> fetchAnnounces() async {
    isLoading(true);
    try {
      final fetchedAnnounces = await adService.getMyannonces();
      announces.assignAll(fetchedAnnounces);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch announces: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    code = Get.arguments['code'];
    codeuse = Get.arguments['codeuse'];


    fetchAnnounces();
  }
}
