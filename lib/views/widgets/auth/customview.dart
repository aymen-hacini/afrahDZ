import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:afrahdz/views/screens/auth/forgetpassword/forgetpassword.dart';
import 'package:afrahdz/views/widgets/auth/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomView extends GetView<LoginController> {
  final String text;
  final String userType;
  final bool ismemeberSelected;
  final TextEditingController emailcontroller, passwordcontroller;
  const CustomView(
      {super.key,
      required this.text,
      required this.userType,
      required this.emailcontroller,
      required this.passwordcontroller,
      required this.ismemeberSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextField(
          controller: emailcontroller,
          hint: "Enter your email",
          keyboardtype: TextInputType.emailAddress,
          image: AppImages.mailIcon,
        ),
        SizedBox(
          height: height * .03,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Obx(
            () => TextFormField(
              controller: passwordcontroller,
              obscureText: controller.isObscured.value,
              cursorColor: Appcolors.primaryColor,
              decoration: InputDecoration(
                  fillColor: const Color(0x33C4C4C4),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 15.91,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: "Enter your password",
                  suffixIcon: GestureDetector(
                    onTap: controller.toggleObscure,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      child: controller.isObscured.value
                          ? SvgPicture.asset(
                              AppImages.lockIcon,
                              fit: BoxFit.contain,
                              key: const ValueKey("eye_close"),
                            )
                          : SvgPicture.asset(
                              AppImages.unlockSvg,
                              fit: BoxFit.contain,
                              key: const ValueKey("eye_open"),
                            ),
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => Checkbox(
                value: controller.rememberMe.value,
                onChanged: (value) {
                  controller.rememberMe.value = value!;
                },
                checkColor: Colors.black,
                activeColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
            const Text(
              "Se souvenir de moi.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6C7278),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 0.12,
                letterSpacing: -0.12,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.to(() => const Forgetpassword(),
                  arguments: {"isMemberSelected": ismemeberSelected},
                  transition: Transition.fadeIn),
              child: Text(
                'Mot de passe oublié ?',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Appcolors.primaryColor,
                  fontSize: 10.23,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
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
                onPressed: () => Future.delayed(
                    1.seconds,
                    () => controller.login(emailcontroller.text,
                        passwordcontroller.text, userType)),
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
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Se Connecter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 20,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                )),
          ),
        ),
        SizedBox(
          height: height * .02,
        ),
        InkWell(
          onTap: () {
            controller.selectedImage.value = null;
            Get.toNamed(AppRoutesNames.signup);
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
                const TextSpan(
                  text: ' Inscrivez-vous maintenant.',
                  style: TextStyle(
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
