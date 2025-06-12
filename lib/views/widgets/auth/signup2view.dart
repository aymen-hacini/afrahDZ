import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:afrahdz/views/widgets/auth/customtextfield.dart';
import 'package:afrahdz/views/widgets/edit/ville_picker.dart';
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
            //          physics: const ClampingScrollPhysics(),
            children: [
              CustomTextField(
                controller: controller.memberphoneController,
                hint: "SignupMobile".tr,
                validator: (value) {
                  if (value!.length < 10) {
                    return "phone non valide".tr;
                  }
                  return null;
                },
                keyboardtype: TextInputType.number,
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberfixeController,
                keyboardtype: TextInputType.number,
                validator: (value) {
                  if (value!.length < 8) {
                    return "phone non valide".tr;
                  }
                  return null;
                },
                hint: "SignupFixe".tr,
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              const SignupWilayapicker(),
              // CustomTextField(
              //   controller: controller.memberwilayaController,
              //   hint: "SignupCity".tr,
              //   image: AppImages.locationIcon,
              // ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberlocationController,
                hint: "SignupAdrress".tr,
                image: AppImages.locationIcon,
              ),
              
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.referralCodeController,
                hint: "SignupRefcode".tr,
                image: "assets/svg/refcode.svg",
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
              GestureDetector(
                onTap: () {
                  controller.clearControllers();
                  Get.offNamed(AppRoutesNames.login);
                },
                child: Text.rich(
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
                ),
              )
            ],
          )
        : Column(
            //          physics: const ClampingScrollPhysics(),
            children: [
              CustomTextField(
                controller: controller.phoneController,
                keyboardtype: TextInputType.phone,
                hint: "SignupMobile".tr,
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              const SignupWilayapicker(),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.ageController,
                keyboardtype: TextInputType.number,
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
              GestureDetector(
                onTap: () {
                  controller.clearControllers();
                  Get.offNamed(AppRoutesNames.login);
                },
                child: Text.rich(
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
                ),
              )
            ],
          );
  }
}
