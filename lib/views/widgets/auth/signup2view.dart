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
                hint: "Tel",
                keyboardtype: TextInputType.number,
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberfixeController,
                keyboardtype: TextInputType.number,

                hint: "tel fixe",
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberwilayaController,
                hint: "Ville",
                image: AppImages.locationIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.memberlocationController,
                hint: "Adresse",
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
                            : const Center(
                                child: Text(
                                  "S'inscrire",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                    const TextSpan(
                      text: 'Connectez-vous.',
                      style: TextStyle(
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
                hint: "Tel",
                image: AppImages.phoneIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.wilayaController,
                hint: "Ville",
                image: AppImages.locationIcon,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: controller.ageController,
                hint: "Age",
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
                            : const Center(
                                child: Text(
                                  "S'inscrire",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                    const TextSpan(
                      text: 'Connectez-vous.',
                      style: TextStyle(
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
