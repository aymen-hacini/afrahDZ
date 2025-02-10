import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:afrahdz/views/widgets/auth/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup2view extends StatelessWidget {
  final String text;
  final bool isMember;
  const Signup2view({
    super.key,
    required this.text,
    required this.isMember,
  });

  @override
  Widget build(BuildContext context) {
    return isMember
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controller: controller.memberphoneController,
                hint: "SignupMobile".tr,
                keyboardtype: TextInputType.number,
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberfixeController,
                keyboardtype: TextInputType.number,
                hint: "SignupFixe".tr,
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberwilayaController,
                hint: "SignupCity".tr,
                image: AppImages.locationIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberlocationController,
                hint: "SignupAdrress".tr,
                image: AppImages.locationIcon,
              ),
              SizedBox(
                height: height * .03,
              ),
              Obx(
                () => AnimatedContainer(
                  duration: 300.milliseconds,
                  curve: Curves.bounceInOut,
                  width: controller.isLoading.value ? width * .2 : width * .7,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, // Remove default padding
                          shadowColor: Colors.black, // Remove default shadow
                          elevation: 4),
                      onPressed: () => controller.signupMember(),
                      child: Ink(
                        height: height * .06,
                        decoration: BoxDecoration(
                            gradient: Appcolors.primaryGradient,
                            borderRadius: BorderRadius.circular(11)),
                        child: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Signup2BtnText".tr,
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
              SizedBox(
                height: height * .01,
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
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controller: controller.phoneController,
                hint: "SignupMobile".tr,
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.wilayaController,
                hint: "SignupCity".tr,
                image: AppImages.locationIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.ageController,
                hint: "SignupAge".tr,
                image: AppImages.ageIcon,
              ),
              SizedBox(
                height: height * .03,
              ),
              Obx(
                () => AnimatedContainer(
                  duration: 300.milliseconds,
                  curve: Curves.bounceInOut,
                  width: controller.isLoading.value ? width * .2 : width * .7,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, // Remove default padding
                          shadowColor: Colors.black, // Remove default shadow
                          elevation: 4),
                      onPressed: () => controller.signupClient(),
                      child: Ink(
                        height: height * .06,
                        decoration: BoxDecoration(
                            gradient: Appcolors.primaryGradient,
                            borderRadius: BorderRadius.circular(11)),
                        child: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Signup2BtnText".tr,
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
              SizedBox(
                height: height * .01,
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
