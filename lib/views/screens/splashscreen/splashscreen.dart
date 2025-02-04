import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    // Use GetX to handle the delay and navigation
    Future.delayed(const Duration(seconds: 3), () {
      if (controller.isLoggedIn) {
        controller.autoLogin();
      }
      Get.offAllNamed(AppRoutesNames.homepage, arguments: {"isMember": false});
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/logo.svg"),
            const SizedBox(height: 20), // Spacing
            CircularProgressIndicator(
              color: Appcolors.primaryColor,
            ), // Loading indicator
          ],
        ),
      ),
    );
  }
}
