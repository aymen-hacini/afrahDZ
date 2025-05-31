import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/controllers/homepage/homepage_controller.dart';
import 'package:afrahdz/controllers/homepage/textcontroller.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/details/ad_detail.dart';
import 'package:afrahdz/views/screens/edit/edit_profile.dart';
import 'package:afrahdz/views/screens/homepage/all_ads.dart';
import 'package:afrahdz/views/screens/homepage/search.dart';
import 'package:afrahdz/views/widgets/categorie/categorie_card.dart';
import 'package:afrahdz/views/widgets/homepage/categorie_title.dart';
import 'package:afrahdz/views/widgets/homepage/custom_tile.dart';
import 'package:afrahdz/views/widgets/homepage/premium_card.dart';
import 'package:afrahdz/views/widgets/homepage/profile_avatar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends GetView<HomePageController> {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    LoginController loginController = Get.find();
    Textcontroller textcontroller = Get.put(Textcontroller(), permanent: false);
    return GetBuilder<HomePageController>(
      builder: (con) => Scaffold(
        drawer: controller.userDetails.value == null
            ? null
            : Drawer(
                backgroundColor: Colors.white,
                width: AppSize.appwidth * .8,
                child: SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: AppSize.appheight * 1.1,
                      child: Obx(
                        () {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: AppSize.appheight * .02,
                                    left: AppSize.appwidth * .03),
                                child: GestureDetector(
                                  onTap: () => (Get.to(
                                      () => const EditProfile(),
                                      transition: Transition.zoom,
                                      arguments: {
                                        "isMember": controller.isMemberLoggedIn
                                      })),
                                  child: HomepageProfileAvatar(
                                    profileImage: controller
                                        .userDetails.value!.profilePicture!,
                                    borderSvg: AppImages.avatarNoCamSvg,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: Get.locale!.languageCode == "ar"
                                          ? 0
                                          : AppSize.appwidth * .05,
                                      right: Get.locale!.languageCode == "ar"
                                          ? AppSize.appwidth * .05
                                          : 0,
                                    ),
                                    child: Text(
                                      " ${controller.userDetails.value!.name}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: Get.locale!.languageCode == "ar"
                                          ? 0
                                          : AppSize.appwidth * .05,
                                      left: Get.locale!.languageCode == "ar"
                                          ? AppSize.appwidth * .05
                                          : 0,
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          final box = GetStorage();
                                          var newLocale =
                                              Get.locale?.languageCode == 'ar'
                                                  ? const Locale('fr', 'FR')
                                                  : const Locale('ar', 'EG');

                                          Get.updateLocale(newLocale);
                                          box.write(
                                              'locale',
                                              newLocale
                                                  .languageCode); // Save locale
                                        },
                                        icon: const Icon(Icons.language)),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.locale!.languageCode == "ar"
                                      ? 0
                                      : AppSize.appwidth * .05,
                                  right: Get.locale!.languageCode == "ar"
                                      ? AppSize.appwidth * .05
                                      : 0,
                                ),
                                child: Text(
                                  controller.userDetails.value!.wilaya,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: AppSize.appheight * .005,
                              ),
                              Divider(
                                  color: const Color(0x99535353),
                                  thickness: 1,
                                  indent: AppSize.appwidth * .04,
                                  endIndent: AppSize.appwidth * .04),
                              CustomTile(
                                ontap: () =>
                                    Get.toNamed(AppRoutesNames.favorites),
                                title: "HomepageFavoriteTile".tr,
                                svg: "assets/svg/favoris.svg",
                              ),
                              controller.isMemberLoggedIn
                                  ? CustomTile(
                                      ontap: () => Get.toNamed(
                                          AppRoutesNames.addannonce),
                                      title: "HomepageAddAdTile".tr,
                                      svg: "assets/svg/add.svg")
                                  : const SizedBox.shrink(),
                              controller.isMemberLoggedIn
                                  ? CustomTile(
                                      ontap: () => Get.toNamed(
                                          AppRoutesNames.boosterAnnonce),
                                      title: "HomepageBoostAdTile".tr,
                                      svg: "assets/svg/boost.svg")
                                  : const SizedBox.shrink(),
                              controller.isMemberLoggedIn
                                  ? CustomTile(
                                      ontap: () => Get.toNamed(
                                          AppRoutesNames.mesannonces),
                                      title: "HomepageMyAdsTile".tr,
                                      svg: "assets/svg/mesannonces.svg")
                                  : const SizedBox.shrink(),
                              CustomTile(
                                ontap: () => Get.toNamed(
                                    controller.isMemberLoggedIn
                                        ? AppRoutesNames.memberReservations
                                        : AppRoutesNames.clientReservations),
                                title: "HomepageMyreservationsTile".tr,
                                svg: "assets/svg/reserve.svg",
                              ),
                              controller.isMemberLoggedIn
                                  ? CustomTile(
                                      ontap: () =>
                                          Get.toNamed(AppRoutesNames.planning),
                                      title: "HomepageMyplaningTile".tr,
                                      svg: "assets/svg/planning.svg",
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              Divider(
                                  color: const Color(0x99535353),
                                  thickness: 1,
                                  indent: AppSize.appwidth * .04,
                                  endIndent: AppSize.appwidth * .04),
                              CustomTile(
                                ontap: () =>
                                    Get.toNamed(AppRoutesNames.contact),
                                title: "HomepageContactTile".tr,
                                svg: "assets/svg/contact.svg",
                              ),
                              CustomTile(
                                ontap: () => Get.toNamed(AppRoutesNames.about),
                                title: "HomepageAboutTile".tr,
                                svg: "assets/svg/about.svg",
                              ),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              Divider(
                                  color: const Color(0x99535353),
                                  thickness: 1,
                                  indent: AppSize.appwidth * .04,
                                  endIndent: AppSize.appwidth * .04),
                              CustomTile(
                                ontap: () => controller.logout(),
                                title: "HomepageLogoutTile".tr,
                                svg: "assets/svg/exit.svg",
                              ),
                              const Spacer(),
                              SizedBox(
                                height: AppSize.appheight * .02,
                              ),
                              Divider(
                                  color: const Color(0x99535353),
                                  thickness: 1,
                                  indent: AppSize.appwidth * .02,
                                  endIndent: AppSize.appwidth * .02),
                              Row(
                                children: [
                                  SizedBox(
                                    width: AppSize.appheight * .02,
                                  ),
                                  GestureDetector(
                                      onTap: () => controller.launchCustomUrl(
                                          "https://www.facebook.com/profile.php?id=61552410582334"),
                                      child: SvgPicture.asset(
                                          "assets/svg/fb.svg")),
                                  SizedBox(
                                    width: AppSize.appheight * .02,
                                  ),
                                  GestureDetector(
                                      onTap: () => controller.launchCustomUrl(
                                          "https://www.instagram.com/afrah_algerie/"),
                                      child: SvgPicture.asset(
                                          "assets/svg/ig.svg")),
                                  SizedBox(
                                    width: AppSize.appheight * .02,
                                  ),
                                  GestureDetector(
                                      onTap: () => controller.launchCustomUrl(
                                          "https://www.youtube.com/@Afrah_DZ"),
                                      child: SvgPicture.asset(
                                          "assets/svg/youtube.svg")),
                                  SizedBox(
                                    width: AppSize.appheight * .02,
                                  ),
                                  GestureDetector(
                                      onTap: () => controller.launchCustomUrl(
                                          "https://x.com/AfrahnaDZ"),
                                      child:
                                          SvgPicture.asset("assets/svg/x.svg")),
                                  SizedBox(
                                    width: AppSize.appheight * .02,
                                  ),
                                  GestureDetector(
                                      onTap: () => controller.launchCustomUrl(
                                          "https://www.tiktok.com/@afrah.dz"),
                                      child: SvgPicture.asset(
                                          "assets/svg/tiktok.svg")),
                                ],
                              ),
                              SizedBox(
                                height: AppSize.appheight * .02,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                )),
        body: SafeArea(
            child: Container(
          color: Colors.white,
          height: AppSize.appheight,
          width: AppSize.appwidth,
          child: ListView(
            controller: controller.scrollController,
            children: [
              Row(
                children: [
                  Obx(
                    () => controller.userDetails.value == null
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Builder(builder: (context) {
                              return IconButton(
                                  onPressed: () {
                                    loginController.clearControllers();
                                    Get.toNamed(AppRoutesNames.login);
                                  },
                                  icon: const Icon(
                                    Icons.person_outline,
                                    color: Colors.black,
                                  ));
                            }),
                          )
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Builder(builder: (context) {
                              return IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                  ));
                            }),
                          ),
                  ),
                  SizedBox(
                    width: AppSize.appwidth * .22,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                          width: AppSize.appwidth * .27,
                          height: AppSize.appheight * .03,
                          child: SvgPicture.asset(
                            'assets/svg/logo2.svg',
                            fit: BoxFit.cover,
                          ))),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Get.to(const SearchProducts(),
                          transition: Transition.fadeIn),
                      icon: const Icon(Icons.search_outlined)),
                  Padding(
                    padding: EdgeInsets.only(
                      right: Get.locale!.languageCode == "ar"
                          ? 0
                          : AppSize.appwidth * .02,
                      left: Get.locale!.languageCode == "ar"
                          ? AppSize.appwidth * .02
                          : 0,
                    ),
                    child: GetBuilder<HomePageController>(
                      builder: (cont) => IconButton(
                          onPressed: () {
                            final box = GetStorage();
                            var newLocale = Get.locale?.languageCode == 'ar'
                                ? const Locale('fr', 'FR')
                                : const Locale('ar', 'EG');

                            Get.updateLocale(newLocale);
                            box.write('locale',
                                newLocale.languageCode); // Save locale
                          },
                          icon: Text(Get.locale?.languageCode == "ar"
                              ? "Fr"
                              : "عربي")),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: AppSize.appheight * .025,
              ),
              GestureDetector(
                onTap: () => Get.to(() => const AllVipAds(),
                    transition: Transition.upToDown),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedBuilder(
                    animation: textcontroller.animation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(-textcontroller.animation.value, 0),
                      child: Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "HomepageTitlepart1".tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "HomepageTitlepart2".tr,
                                  style: const TextStyle(
                                    color: Color(0xFFC628BC),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "HomepageTitlepart3".tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlayAnimationDuration: 100.milliseconds,
                          animateToClosest: true,
                          viewportFraction: .7,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          padEnds: true,
                          enlargeFactor: .45,
                          autoPlay: true,
                          aspectRatio: 4 / 3,
                          onPageChanged: (index, reason) {
                            controller.updatePageIndex(index);
                          },
                          enlargeCenterPage: true,
                        ),
                        items: List.generate(
                            4,
                            (i) => const PremiumCard(
                                name: "", image: "", rating: 0)),
                      ));
                } else {
                  return controller.vipAds.isEmpty
                      ? Center(
                          child: Text("Noads".tr),
                        )
                      : AnimatedOpacity(
                          duration: 400.milliseconds,
                          opacity: controller.carouselOpacity.value,
                          child: Transform.scale(
                            scale: controller.carouselScale.value,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlayAnimationDuration: 100.milliseconds,
                                animateToClosest: true,
                                initialPage: 0,
                                viewportFraction:
                                    Get.locale!.languageCode == "ar" ? .63 : .7,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                padEnds: true,
                                enlargeFactor: Get.locale!.languageCode == "ar"
                                    ? .28
                                    : .45,
                                autoPlay: true,
                                aspectRatio: Get.locale!.languageCode == "ar"
                                    ? 4 / 3
                                    : 4 / 3,
                                onPageChanged: (index, reason) {
                                  controller.updatePageIndex(index);
                                },
                                enlargeCenterPage: true,
                              ),
                              items:
                                  List.generate(controller.vipAds.length, (i) {
                                final ad = controller.vipAds[i];
                                return AnimatedOpacity(
                                  duration: 100.milliseconds,
                                  opacity:
                                      i == controller.currentPageIndex.value
                                          ? 1
                                          : 0.5,
                                  child: GestureDetector(
                                      onTap: () => ad.id == 130
                                          ? null
                                          : Get.to(() => AdDetail(adId: ad.id),
                                              transition: Transition.zoom),
                                      child: PremiumCard(
                                        name: ad.name,
                                        image: ad.imageFullPath,
                                        rating: ad.rating,
                                      )),
                                );
                              }),
                            ),
                          ),
                        );
                }
              }),
              SizedBox(
                height: AppSize.appheight * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CategorieTitle(
                  title: "CategorieTitle".tr,
                ),
              ),
              SizedBox(height: AppSize.appheight * .02),
              Obx(() {
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                            2,
                            (i) => Container(
                                height: AppSize.appheight * .3,
                                width: AppSize.appwidth,
                                margin: EdgeInsets.symmetric(
                                    horizontal: AppSize.appwidth * .02,
                                    vertical: AppSize.appheight * .02),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ))),
                      ));
                } else if (controller.categories.isEmpty) {
                  return Center(child: Text('Noads'.tr));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                        children: List.generate(controller.categories.length,
                            (index) {
                      final category = controller.categories[index];
                      return GestureDetector(
                        onTap: () {
                          controller.selectedCat = category.name;
                          controller.showLocationpicker(category.name);
                          controller.selectedCat = category.name;
                        },
                        child: CategorieCard(
                          selectedCat: category,
                        ),
                      );
                    })),
                  );
                }
              }),
            ],
          ),
        )),
      ),
    );
  }
}
