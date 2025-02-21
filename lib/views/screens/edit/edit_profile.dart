import 'package:afrahdz/controllers/edit/edit_profile_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/edit/date_picker.dart';
import 'package:afrahdz/views/widgets/edit/ville_picker.dart';
import 'package:afrahdz/views/widgets/homepage/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class EditProfile extends GetView<EditProfileController> {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditProfileController());
    return SmartRefresher(
      controller: RefreshController(),
      header: WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      child: Scaffold(
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.appwidth * .04,
          ),
          height: AppSize.appheight,
          width: AppSize.appwidth,
          color: Colors.white,
          child: Stack(
            children: [
              Obx(
                () {
                  return controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Appcolors.primaryColor,
                          ),
                        )
                      : ListView(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSize.appheight * .01),
                              child: Center(
                                child: GradientText(
                                  text: "EditprofileTitle".tr,
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
                                child: controller.selectedImage.value == null
                                    ? GestureDetector(
                                        onTap: () =>
                                            controller.showImagePickerModal(),
                                        child: HomepageProfileAvatar(
                                          profileImage: controller.userDetails
                                              .value!.profilePicture!,
                                          borderSvg: AppImages.avatarSvg,
                                          size: 130,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () =>
                                            controller.showImagePickerModal(),
                                        child: ProfileAvatar(
                                          profileImage:
                                              controller.selectedImage.value!,
                                          borderSvg: AppImages.avatarSvg,
                                          size: 130,
                                        ),
                                      )),
                            SizedBox(
                              height: AppSize.appheight * .03,
                            ),
                            Text(
                              "EditprofileName".tr,
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
                              onChanged: (value) =>
                                  controller.nameController.text = value,
                              initialValue: controller.userDetails.value!.name,
                              style: const TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.88,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6))),
                            ),
                            SizedBox(
                              height: AppSize.appheight * .01,
                            ),
                            Text(
                              "EditprofileEmail".tr,
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
                              initialValue: controller.userDetails.value!.email,
                              onChanged: (value) =>
                                  controller.emailController.text = value,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.88,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6))),
                            ),
                            SizedBox(
                              height: AppSize.appheight * .01,
                            ),
                            Text(
                              "EditprofilePhone".tr,
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
                              onChanged: (value) =>
                                  controller.phoneController.text = value,
                              initialValue: controller.userDetails.value!.phone,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.88,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6))),
                            ),
                            SizedBox(
                              height: AppSize.appheight * .01,
                            ),
                            controller.isMemberLoggedIn
                                ? Text(
                                    'EditprofileFixe'.tr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0.88,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: controller.isMemberLoggedIn
                                  ? AppSize.appheight * .01
                                  : 0,
                            ),
                            controller.isMemberLoggedIn
                                ? TextFormField(
                                    onChanged: (value) =>
                                        controller.fixeController.text = value,
                                    initialValue:
                                        controller.userDetails.value!.fixe,
                                    keyboardType: TextInputType.phone,
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
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(6))),
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: AppSize.appheight * .01,
                            ),
                            Text(
                              'EditprofileDateofbirth'.tr,
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
                              onChanged: (value) {},
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.88,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6))),
                            ),
                            SizedBox(
                              height: AppSize.appheight * .01,
                            ),
                            Text(
                              'EditprofileCity'.tr,
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
                            const EditProfileCityPicker(),
                            SizedBox(
                              height: AppSize.appheight * .02,
                            ),
                            Obx(
                              () => AnimatedContainer(
                                duration: 300.milliseconds,
                                width: controller.isLoading.value
                                    ? AppSize.appwidth * .2
                                    : AppSize.appwidth * .8,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Remove default padding
                                        shadowColor: Colors
                                            .black, // Remove default shadow
                                        elevation: 4),
                                    onPressed: () {
                                      final storage = GetStorage();

                                      final decodedToken = JwtDecoder.decode(
                                          storage.read('token'));

                                      decodedToken['role'] == 'membre'
                                          ? controller.modifyMembre(controller
                                              .userDetails.value!.id
                                              .toString())
                                          : controller.modifyClient(controller
                                              .userDetails.value!.id
                                              .toString());
                                    },
                                    child: Ink(
                                      height: AppSize.appheight * .06,
                                      decoration: BoxDecoration(
                                          gradient: Appcolors.primaryGradient,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: controller.isLoading.value
                                            ? const CircularProgressIndicator
                                                .adaptive(
                                                backgroundColor: Colors.white,
                                              )
                                            : Text(
                                                "EditprofilebtnText".tr,
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
                          ],
                        );
                },
              ),
              InkWell(
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
            ],
          ),
        )),
      ),
    );
  }
}
