import 'package:afrahdz/controllers/homepage/homepage_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/details/ad_detail.dart';
import 'package:afrahdz/views/widgets/homepage/custom_textfield.dart';
import 'package:afrahdz/views/widgets/homepage/full_details.dart';
import 'package:afrahdz/views/widgets/homepage/generic_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomepageAllproducts extends GetView<HomePageController> {
  const HomepageAllproducts({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: Container(
        height: AppSize.appheight,
        width: AppSize.appwidth,
        color: Colors.white,
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Appcolors.primaryColor,
                ),
              );
            } else {
              return ListView(
                children: [
                  SizedBox(
                    height: AppSize.appwidth * .02,
                  ),
                  Center(
                      child: SizedBox(
                          width: AppSize.appwidth * .27,
                          height: AppSize.appheight * .03,
                          child: SvgPicture.asset(
                            'assets/svg/logo2.svg',
                            fit: BoxFit.cover,
                          ))),
                  SizedBox(
                    height: AppSize.appwidth * .03,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSize.appwidth * .045),
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(4),
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
                      Expanded(
                        flex: 6,
                        child: CustomTextfield2(
                          prefixIcon: const Icon(Icons.search_outlined),
                          hint: "SearchHint".tr,
                          search: (name) {
                            controller.searchByname(
                                name, controller.selectedCat!);
                          },
                        ),
                      ),
                    ],
                  ),

                 
                  
                  SizedBox(height: AppSize.appheight * .02),
                  controller.goldAds.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "GoldTitleText".tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: AppSize.appheight * .01,
                  ),
                  controller.goldAds.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: Get.width,
                          height: Get.height * .3,
                          child: SmartRefresher(
                            scrollDirection: Axis.horizontal,
                            controller: RefreshController(),
                            onLoading: () =>
                                controller.fetchGoldadswithNextpage(
                                    controller.selectedWilaya.value,
                                    controller.selectedCat!,
                                    controller.selectedFete.value),
                            child: CarouselSlider(
                                items: List.generate(
                                  controller.goldAds.length,
                                  (i) {
                                    final ad = controller.goldAds[i];
                                    return GestureDetector(
                                      onTap: () => Get.to(
                                          () => AdDetail(
                                                adId: ad.id,
                                              ),
                                          transition: Transition.fadeIn),
                                      child: GenericServiceCard(
                                        selectedAd: ad,
                                      ),
                                    );
                                  },
                                ),
                                options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    disableCenter: false,
                                    animateToClosest: true,
                                    viewportFraction: .65,
                                    autoPlay: true,
                                    padEnds: false,
                                    height: AppSize.appheight * .31,
                                    autoPlayCurve: Curves.easeInOut,
                                    scrollDirection: Axis.horizontal)),
                          ),
                        ),
                  SizedBox(height: AppSize.appheight * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "NormalTitleText".tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.appheight * .02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      controller.selectedWilaya.value == ""
                          ? controller.vipAds.length
                          : controller.vipAds.length,
                      (i) {
                        final ad = controller.selectedWilaya.value == ""
                            ? controller.vipAds[i]
                            : controller.vipAds[i];
                        return GestureDetector(
                          onTap: () => Get.to(
                              () => AdDetail(
                                    adId: ad.id,
                                  ),
                              arguments: {"id": ad.id},
                              transition: Transition.rightToLeftWithFade),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FullDetails(
                              selectedad: ad,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      )),
    );
  }
}
