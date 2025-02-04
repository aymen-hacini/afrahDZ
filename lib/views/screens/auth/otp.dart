import 'package:afrahdz/controllers/auth/forget_password_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Otp extends GetView<ForgetPasswordController> {
  final String email;
  const Otp({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: AppSize.appheight,
        width: AppSize.appwidth,
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.appwidth * .04,
            vertical: AppSize.appheight * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
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
                SizedBox(
                  width: AppSize.appwidth * .04,
                ),
                const Flexible(
                  child: Text(
                    'Vérifiez votre boite email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w800,
                      height: 1.30,
                      letterSpacing: -0.27,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.appheight * 0.02),
            Text(
              "Nous avons envoyé un SMS avec un code d'activation à votre email $email.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.699999988079071),
                fontSize: 16.19,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.25,
              ),
            ),
            SizedBox(height: AppSize.appheight * 0.05),
            Expanded(
              child: OtpTextField(
                numberOfFields: 5,
                borderColor: Colors.grey,
                fieldWidth: 60,
                cursorColor: Appcolors.primaryColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                borderRadius: BorderRadius.circular(15),

                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),

                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                onCodeChanged: (String value) {
                  controller.usercode = int.parse(value);
                },
                onSubmit: (String verificationCode) {
                  controller.verifyOtp(int.parse(verificationCode));
                },
              ),
            ),
            SizedBox(height: AppSize.appheight * 0.05),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove default padding
                    shadowColor: Colors.black, // Remove default shadow
                    elevation: 4),
                onPressed: () => controller.verifyOtp(controller.usercode),
                child: Ink(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.appheight * .02,
                      horizontal: AppSize.appwidth * .25),
                  decoration: BoxDecoration(
                      gradient: Appcolors.primaryGradient,
                      borderRadius: BorderRadius.circular(11)),
                  child: const Text(
                    'Vérifiez',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFBFBFB),
                      fontSize: 20,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
            SizedBox(height: AppSize.appheight * 0.05),
            GestureDetector(
              onTap: () {
                if (controller.isMemberSelected) {
                  controller.sendOtptoMember();
                } else {
                  controller.sendOtptoClient();
                }

                Get.snackbar("Success", "le code est renvoyé");
              },
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Je n'ai pas reçu le code. ",
                      style: TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 14.77,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'Renvoi du code',
                      style: TextStyle(
                        color: Color(0xFFC628BC),
                        fontSize: 16.19,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
