import 'package:afrahdz/controllers/ad/boost_ad_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/annonces/gold_boost_card.dart';
import 'package:afrahdz/views/widgets/annonces/silver_boost_card.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostAnnonce extends StatelessWidget {
  const BoostAnnonce({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BoostAdController());
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        height: AppSize.appheight,
        width: AppSize.appwidth,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: AppSize.appheight * .025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.appwidth * .045, vertical: 4),
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: ShapeDecoration(
                            shape: const CircleBorder(eccentricity: 0),
                            gradient: Appcolors.backbuttonGradient),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSize.appwidth * .1,
                  ),
                  GradientText(
                    text: "boostadTitle".tr,
                    gradient: Appcolors.primaryGradient,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .01,
            ),
            Expanded(
              child: ListView(
                children: [
                  GoldBoostCard(
                    isVIP: true,
                    type: 'Gold',
                    desc: "GoldDesc".tr,
                    advantages: [
                      "avantage1".tr,
                      "avantage2".tr,
                      "avantage3".tr,
                      "avantage4".tr,
                    ],
                    price: 7500.00,
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  SilverBoostCard(
                    type: "Silver",
                    desc: "SilverDesc".tr,
                    advantages: [
                      "Silveravantage1".tr,
                      "Silveravantage2".tr,
                      "Silveravantage3".tr,
                    ],
                    isVIP: false,
                    price: 5000.00,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
