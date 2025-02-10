import 'package:afrahdz/controllers/ad/ad_detail.dart';
import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/homepage/member_ads.dart';
import 'package:afrahdz/views/widgets/addetail/info_tile.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:video_player/video_player.dart';

class AdDetail extends GetView<AdDetailController> {
  final int adId;
  const AdDetail({
    super.key,
    required this.adId,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AdDetailController());
    controller.fetchFullAdDetails(adId);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: AppSize.appheight,
          width: AppSize.appwidth,
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Appcolors.primaryColor,
                  ),
                );
              } else {
                final ad = controller.selectedAdDetails.value;
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: AppSize.appheight * .4,
                          width: AppSize.appwidth,
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16)))),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Positioned.fill(
                                child: GetBuilder<AdDetailController>(
                                  builder: (controller) => PageView.builder(
                                    controller: controller.pageController,
                                    onPageChanged: controller.onPageChanged,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 1 +
                                        ad.images.length +
                                        (ad.videoFullPath.isNotEmpty
                                            ? 1
                                            : 0), // Include imageFullPath, additional images, and video
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        // Display the main image (imageFullPath) as the first item
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16)),
                                          child: Image.network(
                                            '${ApiLinkNames.server}${ad.imageFullPath}', // Replace with your API base URL
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      } else if (index <= ad.images.length) {
                                        // Display additional images
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16)),
                                          child: Image.network(
                                            '${ApiLinkNames.server}${ad.images[index - 1].imagePath}', // Replace with your API base URL
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      } else {
                                        // Display the video as the last item (if it exists)
                                        if (controller.videoController !=
                                                null &&
                                            controller.videoController!.value
                                                .isInitialized) {
                                          return AspectRatio(
                                            aspectRatio: controller
                                                .videoController!
                                                .value
                                                .aspectRatio,
                                            child: VideoPlayer(
                                                controller.videoController!),
                                          );
                                        } else {
                                          return Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                            backgroundColor:
                                                Appcolors.primaryColor,
                                          ));
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                              // Circle/Rectangle Indicator

                              Container(
                                height: AppSize.appheight * .1,
                                decoration: ShapeDecoration(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(16),
                                            bottomRight: Radius.circular(16))),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(.7),
                                          Colors.black.withOpacity(.0)
                                        ],
                                        begin:
                                            AlignmentDirectional.bottomCenter,
                                        end: AlignmentDirectional.topCenter)),
                              ),
                              Positioned(
                                  bottom: 10,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      1 +
                                          ad.images.length +
                                          (ad.videoFullPath.isNotEmpty ? 1 : 0),
                                      (index) {
                                        return AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          width: controller.currentPage.value ==
                                                  index
                                              ? 20
                                              : 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color:
                                                controller.currentPage.value ==
                                                        index
                                                    ? Appcolors.primaryColor
                                                    : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              controller.currentPage.value ==
                                                      index
                                                  ? 4
                                                  : 8,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ))),

                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppSize.appwidth * .02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () => Get.back(),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            margin: const EdgeInsets.all(10),
                                            decoration: const ShapeDecoration(
                                                shape: CircleBorder(
                                                    eccentricity: 0),
                                                color: Colors.white),
                                            child: const Icon(
                                              Icons.arrow_back_outlined,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SvgPicture.asset(AppImages.mapsIcon)
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppSize.appheight * .02,
                                        horizontal: AppSize.appwidth * .02),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.fetchMemberAds(
                                                  controller.selectedAdDetails
                                                      .value.idmobmre);
                                              Get.to(() => const MemberAds(),
                                                  transition: Transition.fade);
                                            },
                                            child: Text(
                                              ad.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              color: Colors.white),
                                          child: LikeButton(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 6),
                                            size: 20,
                                            isLiked: controller
                                                    .selectedAdDetails
                                                    .value
                                                    .liked
                                                ? true
                                                : false,
                                            likeBuilder: (bool isLiked) {
                                              return Icon(
                                                Icons.favorite,
                                                color: isLiked
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 20,
                                              );
                                            },
                                            likeCount: ad.likes,
                                            countBuilder: (int? count,
                                                bool isLiked, String text) {
                                              return Text(
                                                text,
                                                style: TextStyle(
                                                  color: isLiked
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                              );
                                            },
                                            onTap: (bool isLiked) async {
                                              if (isLiked) {
                                                controller.likeAd(adId);
                                                Get.snackbar(
                                                    "Success".tr, 'Unlike'.tr);
                                              } else {
                                                controller.likeAd(adId);
                                                Get.snackbar(
                                                    'Success'.tr, 'like'.tr);
                                              }
                                              return !isLiked;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSize.appheight * .02,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.appwidth * .05),
                            height: AppSize.appheight * .5,
                            child: ListView(
                              children: [
                                Text(
                                  'AdDescription'.tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.05,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.appheight * .03,
                                ),
                                Text(
                                  ad.details ?? "",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Color(0xFF6B6B6B),
                                    fontSize: 11.18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.appheight * .03,
                                ),
                                GradientText(
                                  text: "${ad.price.toStringAsFixed(2)} DA",
                                  gradient: Appcolors.primaryGradient,
                                  style: const TextStyle(
                                    color: Color(0xFFC628BC),
                                    fontSize: 18.35,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.appheight * .03,
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  spacing: AppSize.appwidth * .085,
                                  runSpacing: 16,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    InfoTile(
                                      text: ad.mobile,
                                      iconData: Icons.phone,
                                    ),
                                    InfoTile(
                                      text: ad.visits.toString(),
                                      iconData: Icons.visibility_outlined,
                                    ),
                                    controller.selectedAdDetails.value
                                                .category ==
                                            "Salle des fetes"
                                        ? const InfoTile(
                                            text: "1100 m2",
                                            iconData: Icons.straighten_outlined,
                                          )
                                        : const SizedBox.shrink(),
                                    InfoTile(
                                      text: ad.address,
                                      iconData: Icons.location_on_outlined,
                                    ),
                                    controller.selectedAdDetails.value
                                                .category ==
                                            "Salle des fetes"
                                        ? const InfoTile(
                                            text: "200 personnes",
                                            iconData: Icons.group_outlined,
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 200,
                                ),
                                SizedBox(
                                  height: AppSize.appheight * .02,
                                )
                              ],
                            )),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.appwidth * 0.02,
                                vertical: AppSize.appheight * .01),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets
                                        .zero, // Remove default padding
                                    shadowColor:
                                        Colors.black, // Remove default shadow
                                    elevation: 4),
                                onPressed: () => controller.isLoggedIn
                                    ? controller.showReserveForm()
                                    : Get.toNamed(AppRoutesNames.login),
                                child: Ink(
                                  height: AppSize.appheight * .06,
                                  decoration: BoxDecoration(
                                      gradient: Appcolors.primaryGradient,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Reservebtn'.tr,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFFFBFBFB),
                                          fontSize: 20,
                                          fontFamily: 'Mulish',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          controller.selectedAdDetails.value.actions
                                  .contains("cont")
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSize.appwidth * 0.02,
                                      vertical: AppSize.appheight * .01),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      Appcolors.primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          elevation: 4),
                                      onPressed: () => controller.isLoggedIn
                                          ? controller.makePhoneCall(controller
                                              .selectedAdDetails.value.mobile)
                                          : Get.toNamed(AppRoutesNames.login),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GradientText(
                                            text: 'contactBtn'.tr,
                                            gradient: Appcolors.primaryGradient,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
