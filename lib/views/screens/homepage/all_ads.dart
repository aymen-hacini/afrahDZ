import 'package:afrahdz/controllers/homepage/topads_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/details/ad_detail.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/edit/ville_picker.dart';
import 'package:afrahdz/views/widgets/homepage/full_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';


class AllVipAds extends GetView<TopadsController> {
  const AllVipAds({super.key});
  
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TopadsController());  
    return SmartRefresher(
      controller: RefreshController(),
      header: WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      onRefresh: () => controller.fetchTopAds(),
      onLoading: () => controller.fetchTopAdswithNextpage(),
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
                    text: "Top Annonces".tr,
                    gradient: Appcolors.primaryGradient,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 24),
                  )),
                  SizedBox(
                    height: AppSize.appwidth * .05,
                  ),
                  Row(
                    children: [
                      const Expanded(child: TopAdswilayapicker()),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.primaryColor,
                              shape: const StadiumBorder()),
                          onPressed: () => controller.fetchTopAds(
                              wilaya: controller.topAdsSelectedWilaya!),
                          child:  Text(
                            "SearchHint".tr,
                            style: const TextStyle(color: Colors.white),
                          )),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.appwidth * .05,
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.topAds.isEmpty) {
                      return  Center(
                          child: Text('Noads'.tr));
                    } else {
                      return Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final ad = controller.topAds[index];
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
                            itemCount: controller.topAds.length),
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
