import 'package:afrahdz/controllers/ad/my_annonces_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/annonces/my_annonce_card.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MyAnnounces extends GetView<MyAnnoncesController> {
  const MyAnnounces({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyAnnoncesController());
    return SmartRefresher(
      controller: RefreshController(),
      header: WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      onRefresh: ()=>controller.fetchAnnounces(),
      child: Scaffold(
        body: SafeArea(
            child: Container(
          height: AppSize.appheight,
          width: AppSize.appwidth,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: AppSize.appheight * .03),
                    child: Center(
                      child: GradientText(
                        text:"MyAdsTitle".tr,
                        gradient: Appcolors.primaryGradient,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.88,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Expanded(
                    child: Obx(
                      () => controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Appcolors.primaryColor,
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                final selectedAnnonce =
                                    controller.announces[index];
                                return MyAnnonceCard(
                                    selectedAd: selectedAnnonce);
                              },
                              itemCount: controller.announces.length,
                            ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppSize.appheight * .01,
                    left: AppSize.appwidth * .045),
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
            ],
          ),
        )),
      ),
    );
  }
}
