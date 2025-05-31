import 'package:afrahdz/controllers/ad/edit_annonce_controller.dart';
import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/edit/ville_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class EditAnnonce extends GetView<EditAnnonceController> {
  const EditAnnonce({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditAnnonceController());
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
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Appcolors.primaryColor,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppSize.appheight * .02),
                          child: Center(
                            child: GradientText(
                              text: "Modifier une annonce",
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
                                      // ✅ Counter in bottom-left
                                      Positioned(
                                        bottom: 12,
                                        left: 16,
                                        child: Obx(() {
                                          final current = controller
                                                  .currentContainerPageIndex
                                                  .value +
                                              1;
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              "$current/${controller.images.length + (controller.video.value != null ? 1 : 0)}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      PageView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        onPageChanged: (index) {
                                          controller.currentContainerPageIndex
                                              .value = index;

                                          // Initialize or dispose video controller based on the current page
                                          if (controller.video.value != null &&
                                              index ==
                                                  controller.images.length) {
                                            // Scrolled to the video page
                                            controller
                                                .initializeVideoController(
                                                    controller.video.value!);
                                          } else {
                                            // Scrolled away from the video page
                                            controller.disposeVideoController();
                                          }
                                        },
                                        itemCount: controller.images.length +
                                            (controller.video.value != null
                                                ? 1
                                                : 0),
                                        itemBuilder: (context, index) {
                                          if (index <
                                              controller.images.length) {
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
                                                    controller.images
                                                        .removeAt(index);
                                                  },
                                                ),
                                              ],
                                            );
                                          } else {
                                            // Display video
                                            return Obx(() {
                                              if (controller
                                                      .videoController.value !=
                                                  null) {
                                                return ValueListenableBuilder(
                                                  valueListenable: controller
                                                      .videoController.value!,
                                                  builder: (context,
                                                      VideoPlayerValue value,
                                                      child) {
                                                    if (value.isInitialized) {
                                                      return Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                            child: AspectRatio(
                                                              aspectRatio: value
                                                                  .aspectRatio,
                                                              child: VideoPlayer(
                                                                  controller
                                                                      .videoController
                                                                      .value!),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red),
                                                            onPressed: () {
                                                              controller.video
                                                                  .value = null;
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
                                                  child:
                                                      CircularProgressIndicator(),
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Obx(() {
                                            final totalItems = controller
                                                    .images.length +
                                                (controller.video.value != null
                                                    ? 1
                                                    : 0);
                                            final currentPage = controller
                                                    .currentContainerPageIndex
                                                    .value +
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
                                  return Obx(() {
                                    final adDetails =
                                        controller.selectedAdDetails.value!;
                                    final additionalImages = adDetails
                                        .images; // Assume List<String> (relative URLs)
                                    final videoPath = adDetails
                                        .videoFullPath; // Assume nullable String

                                    final totalItems = 1 +
                                        (additionalImages.length ?? 0) +
                                        (videoPath != null ? 1 : 0);

                                    return PageView.builder(
                                      itemCount: totalItems,
                                      physics: const ClampingScrollPhysics(),
                                      onPageChanged: (index) {
                                        controller.currentContainerPageIndex
                                            .value = index;

                                        // Initialize video if it's the last item
                                        if (index == totalItems - 1) {
                                          controller
                                              .initializeVideoControllerNetwork(
                                                  videoPath);
                                        } else {
                                          controller.disposeVideoController();
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          // First image: imageFullPath
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            child: Image.network(
                                              "${ApiLinkNames.serverimage}${adDetails.imageFullPath}",
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          );
                                        }

                                        final imageIndex = index - 1;

                                        if (imageIndex <
                                            (additionalImages.length ?? 0)) {
                                          // Additional images
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            child: Image.network(
                                              "${ApiLinkNames.serverimage}${additionalImages[imageIndex].imagePath}",
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          );
                                        }

                                        // Else: Show video
                                        return Obx(() {
                                          if (controller
                                                  .videoController.value !=
                                              null) {
                                            return ValueListenableBuilder(
                                              valueListenable: controller
                                                  .videoController.value!,
                                              builder: (context,
                                                  VideoPlayerValue value,
                                                  child) {
                                                if (value.isInitialized) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    child: AspectRatio(
                                                      aspectRatio:
                                                          value.aspectRatio,
                                                      child: VideoPlayer(
                                                          controller
                                                              .videoController
                                                              .value!),
                                                    ),
                                                  );
                                                } else {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                              },
                                            );
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        });
                                      },
                                    );
                                  });
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
                              const Text(
                                'Nom Annonce ',
                                style: TextStyle(
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
                                initialValue:
                                    controller.selectedAdDetails.value!.name,
                                onChanged: (value) => controller
                                    .nomAnnoncecontroller.text = value,
                                style: const TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                                cursorColor: Appcolors.primaryColor,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(6)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Appcolors.primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(6))),
                              ),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              const Text(
                                'Categories ',
                                style: TextStyle(
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
                              const EditCategoriePopup(),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              const Text(
                                'Type de fete ',
                                style: TextStyle(
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
                              const EditTypeFetePopup(),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              const Text(
                                'Wilaya ',
                                style: TextStyle(
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
                              const EditAnnonceWilayaPicker(),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              const Text(
                                'Adresse ',
                                style: TextStyle(
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
                                initialValue:
                                    controller.selectedAdDetails.value!.address,
                                onChanged: (value) =>
                                    controller.addressController.text = value,
                                style: const TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0.88,
                                ),
                                cursorColor: Appcolors.primaryColor,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(6)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Appcolors.primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(6))),
                              ),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              const Text(
                                'Description ',
                                style: TextStyle(
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
                                initialValue:
                                    controller.selectedAdDetails.value!.details,
                                onChanged: (value) => controller
                                    .descriptionController.text = value,
                                maxLines: 5,
                                style: const TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0.88,
                                ),
                                cursorColor: Appcolors.primaryColor,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(6)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Appcolors.primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(6))),
                              ),
                              SizedBox(
                                height: AppSize.appheight * .01,
                              ),
                              const Text(
                                'Prix ',
                                style: TextStyle(
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
                                initialValue: controller
                                    .selectedAdDetails.value!.price
                                    .toStringAsFixed(2),
                                onChanged: (value) =>
                                    controller.priceController.text = value,
                                cursorColor: Appcolors.primaryColor,
                                style: const TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0.88,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(6)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Appcolors.primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(6))),
                              ),
                              SizedBox(
                                height: AppSize.appheight * .05,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets
                                          .zero, // Remove default padding
                                      shadowColor:
                                          Colors.black, // Remove default shadow
                                      elevation: 4),
                                  onPressed: () => controller.modifyAd(
                                      controller.selectedAdDetails.value!.id
                                          .toString()),
                                  child: Ink(
                                    height: AppSize.appheight * .06,
                                    decoration: BoxDecoration(
                                        gradient: Appcolors.primaryGradient,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Modifier',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFFBFBFB),
                                            fontSize: 20,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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
