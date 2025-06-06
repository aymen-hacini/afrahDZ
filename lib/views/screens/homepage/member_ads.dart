import 'package:afrahdz/controllers/ad/ad_detail.dart';
import 'package:afrahdz/controllers/favorites/favorites_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/details/ad_detail.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/homepage/full_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MemberAds extends GetView<AdDetailController> {
  const MemberAds({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesController(), permanent: false);
    return SmartRefresher(
      controller: RefreshController(),
      header: WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      onRefresh: () => controller.fetchMemberAds(controller.selectedAdDetails.value.idmobmre),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: Container(
          height: AppSize.appheight,
          width: AppSize.appwidth,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: AppSize.appwidth * .04,
                  ),
                  Center(
                      child: GradientText(
                    text: "Annonces De membre".tr,
                    gradient: Appcolors.primaryGradient,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 24),
                  )),
                  SizedBox(
                    height: AppSize.appwidth * .1,
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.memberAds.isEmpty) {
                      return Center(child: Text("Nofavs".tr));
                    } else {
                      return Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final ad = controller.memberAds[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.appwidth * .03),
                                child: GestureDetector(
                                  onTap: () => Get.to(AdDetail(adId: ad.id),
                                      transition: Transition.fadeIn),
                                  child: FullDetails(
                                    selectedad: ad,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: AppSize.appheight * .015,
                                ),
                            itemCount: controller.memberAds.length),
                      );
                    }
                  }),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSize.appwidth * .045),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                        shape: const CircleBorder(eccentricity: 0),
                        gradient: Appcolors.backbuttonGradient),
                    child: const Icon(
                      Icons.arrow_back_outlined,
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
