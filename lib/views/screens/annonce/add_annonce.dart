import 'package:afrahdz/controllers/ad/create_ad.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/edit/ville_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AddAnnonce extends GetView<CreateAdController> {
  const AddAnnonce({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateAdController());
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.appwidth * .045,
        ),
        height: AppSize.appheight,
        width: AppSize.appwidth,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.appheight * .02),
                  child: Center(
                    child: GradientText(
                      text: "AddAdTitle".tr,
                      gradient: Appcolors.primaryGradient,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.appheight * .02,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => controller.showImagePickerModal(),
                    child: Container(
                      height: AppSize.appheight * .2,
                      width: AppSize.appwidth * .5,
                      decoration: ShapeDecoration(
                        color: const Color(0x00D9D9D9),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFC628BC)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Obx(() {
                        if (controller.images.isNotEmpty ||
                            controller.video.value != null) {
                          return Stack(
                            children: [
                              PageView.builder(
                                scrollBehavior: const CupertinoScrollBehavior(),
                                physics: const ClampingScrollPhysics(),
                                onPageChanged: (index) {
                                  controller.currentContainerPageIndex.value =
                                      index;

                                  // Initialize or dispose video controller based on the current page
                                  if (controller.video.value != null &&
                                      index == controller.images.length) {
                                    // Scrolled to the video page
                                    controller.initializeVideoController(
                                        controller.video.value!);
                                  } else {
                                    // Scrolled away from the video page
                                    controller.disposeVideoController();
                                  }
                                },
                                itemCount: controller.images.length +
                                    (controller.video.value != null ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index < controller.images.length) {
                                    // Display images
                                    return Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: Image.file(
                                            controller.images[index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.white),
                                          onPressed: () {
                                            controller.images.removeAt(index);
                                          },
                                        ),
                                      ],
                                    );
                                  } else {
                                    // Display video
                                    return Obx(() {
                                      if (controller.videoController.value !=
                                          null) {
                                        return ValueListenableBuilder(
                                          valueListenable:
                                              controller.videoController.value!,
                                          builder: (context,
                                              VideoPlayerValue value, child) {
                                            if (value.isInitialized) {
                                              return Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    child: Center(
                                                      child: AspectRatio(
                                                        aspectRatio:
                                                            value.aspectRatio,
                                                        child: VideoPlayer(
                                                            controller
                                                                .videoController
                                                                .value!),
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      controller.video.value =
                                                          null;
                                                      controller
                                                          .disposeVideoController();
                                                    },
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    });
                                  }
                                },
                              ),
                              Positioned(
                                left: 8,
                                bottom: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Obx(() {
                                    final totalItems =
                                        controller.images.length +
                                            (controller.video.value != null
                                                ? 1
                                                : 0);
                                    final currentPage = controller
                                            .currentContainerPageIndex.value +
                                        1;
                                    return Text(
                                      '$currentPage/$totalItems',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppImages.uploadSvg),
                              const SizedBox(height: 8),
                              Text(
                                "Imageplacehoder1".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0.88,
                                ),
                              ),
                              SizedBox(height: AppSize.appheight * .05),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Opacity(
                                  opacity: .5,
                                  child: GradientText(
                                    text: "Imageplacehoder2".tr,
                                    gradient: Appcolors.primaryGradient,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0.88,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.appheight * .03,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        "AdName".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.88,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        controller: controller.nomAnnoncecontroller,
                        cursorColor: Appcolors.primaryColor,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Appcolors.primaryColor),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        "AdCategorie".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      const CategoriePopup(),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        'AdFete'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      const TypeFetePopup(),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        'Adcity'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      const ProvincePopupMenuButton(),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        'EditprofileAddress'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        cursorColor: Appcolors.primaryColor,
                        controller: controller.addressController,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Appcolors.primaryColor),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        "AdDescription".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                          controller: controller.descriptionController,
                          cursorColor: Appcolors.primaryColor,
                          maxLength: 1000,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(6)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Appcolors.primaryColor),
                                  borderRadius: BorderRadius.circular(6))),
                          style: const TextStyle(
                            color: Color(0xFF534C4C),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        "Adprice".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        controller: controller.priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        cursorColor: Appcolors.primaryColor,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Appcolors.primaryColor),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .05,
                      ),
                      Obx(
                        () => AnimatedContainer(
                          duration: 300.milliseconds,
                          margin: EdgeInsets.symmetric(
                            horizontal: controller.isLoading.value
                                ? AppSize.appwidth * .35
                                : AppSize.appwidth * 0,
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // Remove default padding
                                  shadowColor:
                                      Colors.black, // Remove default shadow
                                  elevation: 4),
                              onPressed: () => controller.createAd(),
                              child: Ink(
                                height: AppSize.appheight * .06,
                                decoration: BoxDecoration(
                                    gradient: Appcolors.primaryGradient,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator
                                          .adaptive(
                                          backgroundColor: Colors.white,
                                        )
                                      : Text(
                                          'EditprofilebtnText'.tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFFFBFBFB),
                                            fontSize: 20,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: AppSize.appheight * .015),
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
    );
  }
}
