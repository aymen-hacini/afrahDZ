import 'package:afrahdz/controllers/ad/boost_ad_controller.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/size.dart';

class AnnoncePopupPicker extends GetView<BoostAdController> {
  const AnnoncePopupPicker({super.key});

  // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AdModel>(
      onSelected: (AdModel ad) {
        // Update the selected ad
        controller.updateSelectedAd(ad);
      },
      itemBuilder: (BuildContext context) {
        // Use the myAds list from the controller
        return controller.announces.map((AdModel ad) {
          return PopupMenuItem<AdModel>(
            value: ad,
            child: Text(ad.name), // Display the ad name
          );
        }).toList();
      },
      child: Obx(() {
        return Container(
          width: AppSize.appwidth,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(
                controller.selectedAd.value != null
                    ? controller
                        .selectedAd.value!.name // Display the selected ad name
                    : 'Choose an ad',
                style: const TextStyle(
                  color: Color(0xFF534C4C),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0.88,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_drop_down,
              ),
            ],
          ),
        );
      }),
    );
  }
}
