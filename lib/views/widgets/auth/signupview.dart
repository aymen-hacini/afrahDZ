import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:afrahdz/views/widgets/auth/customtextfield.dart';
import 'package:afrahdz/views/widgets/homepage/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/routes_names.dart';

class Signupview extends GetView<LoginController> {
  final String text;
  final bool ismember;
  const Signupview({
    super.key,
    required this.text,
    required this.ismember,
  });

  @override
  Widget build(BuildContext context) {
    return ismember
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => controller.selectedImage.value == null
                    ? InkWell(
                        onTap: () => controller.showImagePickerModal(),
                        child: SvgPicture.asset(AppImages.avatarSvg),
                      )
                    : GestureDetector(
                        onTap: () => controller.showImagePickerModal(),
                        child: ProfileAvatar(
                          profileImage: controller.selectedImage.value!,
                          borderSvg: AppImages.avatarSvg,
                          size: 120,
                        ),
                      ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.membercommericalnameController,
                hint: "SignupCommercialName".tr,
                image: AppImages.userIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberemailController,
                keyboardtype: TextInputType.emailAddress,
                hint: "emailHinttext".tr,
                image: AppImages.mailIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberpasswordController,
                hint: "passwordHintText".tr,
                keyboardtype: TextInputType.visiblePassword,
                image: AppImages.lockIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberrepeatpasswordController,
                hint: "RepeatPasswordText".tr,
                image: AppImages.lockIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .1),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shadowColor: Colors.black, // Remove default shadow
                        elevation: 4),
                    onPressed: () => Get.toNamed(AppRoutesNames.signup2),
                    child: Ink(
                      height: height * .06,
                      decoration: BoxDecoration(
                          gradient: Appcolors.primaryGradient,
                          borderRadius: BorderRadius.circular(11)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "NextBtnText".tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFFBFBFB),
                              fontSize: 20,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: height * .03,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: text,
                      style: const TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 14.77,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "ConnectNow".tr,
                      style: const TextStyle(
                        color: Color(0xFFC628BC),
                        fontSize: 14.77,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => controller.selectedImage.value == null
                    ? InkWell(
                        onTap: () => controller.showImagePickerModal(),
                        child: SvgPicture.asset(AppImages.avatarSvg),
                      )
                    : GestureDetector(
                        onTap: () => controller.showImagePickerModal(),
                        child: ProfileAvatar(
                          profileImage: controller.selectedImage.value!,
                          borderSvg: AppImages.avatarSvg,
                          size: 120,
                        ),
                      ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.nameController,
                hint: "SignupName".tr,
                image: AppImages.userIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.emailController,
                hint: "emailHinttext".tr,
                image: AppImages.mailIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.passwordController,
                hint: "passwordHintText".tr,
                image: AppImages.lockIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.repeatpasswordController,
                hint: "RepeatPasswordText".tr,
                image: AppImages.lockIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .1),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shadowColor: Colors.black, // Remove default shadow
                        elevation: 4),
                    onPressed: () => Get.toNamed(AppRoutesNames.signup2),
                    child: Ink(
                      height: height * .06,
                      decoration: BoxDecoration(
                          gradient: Appcolors.primaryGradient,
                          borderRadius: BorderRadius.circular(11)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NextBtnText'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFFBFBFB),
                              fontSize: 20,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: text,
                      style: const TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 14.77,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'ConnectNow'.tr,
                      style: const TextStyle(
                        color: Color(0xFFC628BC),
                        fontSize: 14.77,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
