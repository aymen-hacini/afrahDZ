import 'package:afrahdz/controllers/homepage/homepage_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/details/ad_detail.dart';
import 'package:afrahdz/views/widgets/homepage/custom_textfield.dart';
import 'package:afrahdz/views/widgets/homepage/full_details.dart';
import 'package:afrahdz/views/widgets/homepage/generic_card.dart';
import 'package:afrahdz/views/widgets/homepage/premium_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomepageAllproducts extends GetView<HomePageController> {
  const HomepageAllproducts({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return SmartRefresher(
      controller: RefreshController(),
      onRefresh: ()=>controller.fetchNormalads(controller.selectedWilaya.value,controller.selectedCat ?? ""),
     header:  WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      child: Scaffold(
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
                    const Center(
                      child: Text(
                        'AFRAH DZ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21.05,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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
                            hint: "Search ...",
                            search: (name) {
                              controller.searchByname(
                                  name, controller.selectedCat!);
                            },
                          ),
                        ),
                      ],
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        animateToClosest: true,
                        viewportFraction: .7,
                        initialPage: 0,
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        pageSnapping: false,
                        scrollPhysics: const BouncingScrollPhysics(),
                        padEnds: true,
                        enlargeFactor: .45,
                        autoPlay: true,
                        aspectRatio: 4 / 3,
                        onPageChanged: (index, reason) {
                          controller.updatePageIndex(index);
                        },
                        enlargeCenterPage: true,
                      ),
                      items: List.generate(controller.vipAds.length, (i) {
                        final ad = controller.vipAds[i];
                        return AnimatedOpacity(
                            duration: 100.milliseconds,
                            opacity:
                                i == controller.currentPageIndex.value ? 1 : 0.5,
                            child: GestureDetector(
                                onTap: () => Get.to(
                                    () => AdDetail(
                                          adId: ad.id,
                                        ),
                                    transition: Transition.zoom),
                                child: PremiumCard(
                                  name: ad.name,
                                  image: ad.imageFullPath,
                                  rating: ad.rating,
                                )));
                      }),
                    ),
                    controller.goldAds.isEmpty
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Découvrir les meilleures choix',
                              style: TextStyle(
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
                        : CarouselSlider(
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
                    SizedBox(height: AppSize.appheight * .02),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Decouvrir des autres annonces",
                        style: TextStyle(
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
                        controller.normalAds.length,
                        (i) {
                          final ad = controller.normalAds[i];
                          return GestureDetector(
                            onTap: () => Get.to(
                                () => AdDetail(
                                      adId: ad.id,
                                    ),
                                    arguments: {"id":ad.id},
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
      ),
    );
  }
}
