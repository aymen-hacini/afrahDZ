import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FontMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check if the current route is the auth page
    if (route == AppRoutesNames.signup || route == AppRoutesNames.signup2 || route == AppRoutesNames.otp) {
      // Set the font family to Mulisch
      Get.changeTheme(ThemeData(
        fontFamily: "Mulish",
      ));
    } else {
      // Set the font family to Poppins
      Get.changeTheme(ThemeData(
        fontFamily: "Poppins",
      ));
    }
    return null;
  }
}