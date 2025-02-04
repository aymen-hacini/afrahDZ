import 'package:afrahdz/controllers/auth/forget_password_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgetpassword extends GetView<ForgetPasswordController> {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSize.appwidth * .045),
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                          shape: const CircleBorder(eccentricity: 0),
                          gradient: Appcolors.backbuttonGradient),
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Flexible(
                    flex: 6,
                    child: GradientText(
                      text: "Récupérer mot de passe",
                      gradient: Appcolors.primaryGradient,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    )),
              ],
            ),
            SizedBox(
              height: AppSize.appheight * .03,
            ),
            Text(
              "Entrez votre adresse e-mail et nous vous enverrons un code pour réinitialiser votre mot de passe",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.699999988079071),
                fontSize: 16.19,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.25,
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .05,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller.emailController,
                cursorColor: Appcolors.primaryColor,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Appcolors.primaryColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .02,
            ),
            Obx(
              () => AnimatedContainer(
                duration: 300.milliseconds,
                width: controller.isLoading.value
                    ? AppSize.appwidth * .24
                    : AppSize.appwidth * .75,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shadowColor: Colors.black, // Remove default shadow
                        elevation: 0),
                    onPressed: () {
                      if (controller.isMemberSelected) {
                        controller.sendOtptoMember();
                      } else {
                        controller.sendOtptoClient();
                      }
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSize.appheight * .02,
                          horizontal: controller.isLoading.value
                              ? AppSize.appwidth * .05
                              : AppSize.appwidth * .25),
                      decoration: BoxDecoration(
                          gradient: Appcolors.primaryGradient,
                          borderRadius: BorderRadius.circular(11)),
                      child: controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : const Text(
                              'Suivant',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 20,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
