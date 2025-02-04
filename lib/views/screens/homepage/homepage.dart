import 'package:afrahdz/controllers/homepage/homepage_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/details/ad_detail.dart';
import 'package:afrahdz/views/screens/edit/edit_profile.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/categorie/categorie_card.dart';
import 'package:afrahdz/views/widgets/homepage/categorie_title.dart';
import 'package:afrahdz/views/widgets/homepage/custom_tile.dart';
import 'package:afrahdz/views/widgets/homepage/premium_card.dart';
import 'package:afrahdz/views/widgets/homepage/profile_avatar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends GetView<HomePageController> {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () => controller.onRefresh(),
      header: WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      scrollDirection: Axis.vertical,
      child: Scaffold(
        drawer: Drawer(
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
                              onTap: () => (Get.to(() => const EditProfile(),
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
                          controller.userDetails.value != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: AppSize.appwidth * .05),
                                  child: Text(
                                    " ${controller.userDetails.value!.name}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          controller.userDetails.value != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: AppSize.appwidth * .055),
                                  child: Text(
                                    controller.userDetails.value!.wilaya,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: GestureDetector(
                                    onTap: () =>
                                        Get.toNamed(AppRoutesNames.login),
                                    child: GradientText(
                                      text: "Log In",
                                      gradient: Appcolors.primaryGradient,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
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
                            ontap: () => Get.toNamed(AppRoutesNames.favorites),
                            title: "Favorites",
                            svg: "assets/svg/cat.svg",
                          ),
                          controller.isMemberLoggedIn
                              ? CustomTile(
                                  ontap: () =>
                                      Get.toNamed(AppRoutesNames.addannonce),
                                  title: "Ajouter Annonce",
                                  svg: "assets/svg/add.svg")
                              : const SizedBox.shrink(),
                          controller.isMemberLoggedIn
                              ? CustomTile(
                                  ontap: () => Get.toNamed(
                                      AppRoutesNames.boosterAnnonce),
                                  title: "Booster Annonce",
                                  svg: "assets/svg/boost.svg")
                              : const SizedBox.shrink(),
                          controller.isMemberLoggedIn
                              ? CustomTile(
                                  ontap: () =>
                                      Get.toNamed(AppRoutesNames.mesannonces),
                                  title: "Mes Annonces",
                                  svg: "assets/svg/mesannonces.svg")
                              : const SizedBox.shrink(),
                          CustomTile(
                            ontap: () => Get.toNamed(controller.isMemberLoggedIn
                                ? AppRoutesNames.memberReservations
                                : AppRoutesNames.clientReservations),
                            title: "Mes reservations",
                            svg: "assets/svg/reserve.svg",
                          ),
                          CustomTile(
                            ontap: () => Get.toNamed(AppRoutesNames.planning),
                            title: "Mon planning",
                            svg: "assets/svg/planning.svg",
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
                            ontap: () => Get.toNamed(AppRoutesNames.contact),
                            title: "Contact",
                            svg: "assets/svg/contact.svg",
                          ),
                          CustomTile(
                            ontap: () => Get.toNamed(AppRoutesNames.about),
                            title: "About",
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
                            title: "Deconnexion",
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
                              SvgPicture.asset("assets/svg/fb.svg"),
                              SizedBox(
                                width: AppSize.appheight * .02,
                              ),
                              SvgPicture.asset("assets/svg/ig.svg"),
                              SizedBox(
                                width: AppSize.appheight * .02,
                              ),
                              SvgPicture.asset("assets/svg/youtube.svg"),
                              SizedBox(
                                width: AppSize.appheight * .02,
                              ),
                              SvgPicture.asset("assets/svg/x.svg"),
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
                        ? Builder(builder: (context) {
                            return IconButton(
                                onPressed: () =>
                                    Get.toNamed(AppRoutesNames.login),
                                icon: const Icon(
                                  Icons.login_rounded,
                                  color: Colors.black,
                                ));
                          })
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Builder(builder: (context) {
                              return controller.userDetails.value == null
                                  ? IconButton(
                                      onPressed: () =>
                                          Get.toNamed(AppRoutesNames.login),
                                      icon: const Icon(
                                        Icons.login_rounded,
                                        color: Colors.black,
                                      ))
                                  : IconButton(
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
                    width: AppSize.appwidth * .25,
                  ),
                  const Text(
                    'AFRAH DZ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.05,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.appheight * .025,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Découvrir les ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Tops',
                        style: TextStyle(
                          color: Color(0xFFC628BC),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' salles des fêtes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
                      ? const Center(
                          child: Text("There is no ads"),
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
                                      onTap: () => Get.to(
                                          () => AdDetail(adId: ad.id),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CategorieTitle(
                  title: "Categories",
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
                  return const Center(child: Text('No categories found.'));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                        children: List.generate(controller.categories.length,
                            (index) {
                      final category = controller.categories[index];
                      return GestureDetector(
                        onTap: () {
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
