import 'package:afrahdz/controllers/auth/forget_password_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends GetView<ForgetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordController controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.appwidth * .045),
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
                    child: GradientText(
                      text: "Réinitialiser mot de passe",
                      gradient: Appcolors.primaryGradient,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Text("Veuillez entrer votre nouveau mot de passe",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(
                height: AppSize.appheight * .02,
              ),
              TextField(
                controller: controller.newPasswordController,
                decoration: InputDecoration(
                    labelText: 'Nouveau mot de passe',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor),
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: AppSize.appheight * .03,
              ),
              const Text("Veuillez confirmer votre nouveau mot de passe",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(
                height: AppSize.appheight * .02,
              ),
              TextField(
                controller: controller.confirmNewPasswordController,
                decoration: InputDecoration(
                    labelText: 'Confirmer mot de passe',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shadowColor: Colors.black, // Remove default shadow
                        elevation: 4),
                    onPressed: () {
                      if (controller.isMemberSelected) {
                        controller.resetPassowrdMember();
                      } else {
                        controller.resetPassowrdClient();
                      }
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSize.appheight * .02,
                          horizontal: AppSize.appwidth * .25),
                      decoration: BoxDecoration(
                          gradient: Appcolors.primaryGradient,
                          borderRadius: BorderRadius.circular(11)),
                      child: Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                'Confirmer',
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
            ],
          ),
        ),
      ),
    );
  }
}
