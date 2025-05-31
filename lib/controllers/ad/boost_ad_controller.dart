import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:afrahdz/views/widgets/annonces/annonce_popup_picker.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/annonces/duree_popup.dart';
import 'package:afrahdz/views/widgets/annonces/felictation.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';

class BoostAdController extends GetxController {
  final AdService adService = AdService();
  final announces = <AdModel>[].obs;

  Rx<int?> selectedduration = 0.obs;

  final selectedAd = Rx<AdModel?>(null);

  final isLoading = false.obs;

  int? DurationMultiplayer;

  Future<void> boostAd(String type, double finalprice) async {
    try {
      isLoading(true);
      await adService.boostAd(
          duration: selectedduration.value!,
          price: finalprice,
          idAnnonce: selectedAd.value!.id,
          imageUrl:
              "${ApiLinkNames.serverimage}${selectedAd.value!.imageFullPath}",
          type: type);
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

  showBoostOptions(BuildContext context, double price, String type) {
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
          height: AppSize.appheight * .65,
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
              const AnnoncePopupPicker(),
              SizedBox(height: AppSize.appheight * .02),
              Text(
                'La Durée'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0.88,
                ),
              ),
              SizedBox(height: AppSize.appheight * .01),
              const DureePopupButton(),
              SizedBox(height: AppSize.appheight * .02),
              Text(
                'Tarif'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0.88,
                ),
              ),
              SizedBox(height: AppSize.appheight * .01),
              // Dynamic price update with Obx
              Obx(
                () => TextFormField(
                  controller: TextEditingController(
                    text:
                        "${(price * (selectedduration.value! / 5)).toStringAsFixed(2)} DA",
                  ),
                  enableInteractiveSelection: false,
                  enabled: false,
                  style: const TextStyle(
                    color: Color(0xFF534C4C),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.88,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(.8)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              const Spacer(),
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
                      onPressed: () =>
                          boostAd(type, price * (selectedduration.value! / 5)),
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

  // Update the selected ad
  void updateSelectedAd(AdModel ad) {
    selectedAd.value = ad;
  }

  @override
  void onInit() {
    super.onInit();
    fetchAnnounces();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete();
  }
}
