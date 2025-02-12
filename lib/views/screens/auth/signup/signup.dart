import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends GetView<LoginController> {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final height = AppSize.appheight;
    final width = AppSize.appwidth;
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: width * .08, vertical: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "SignupTitle1".tr,
                style:
                    const TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
            ),
            Center(
              child: Text(
                "SignupTitle2".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Expanded(
              child: ListView(children: [
                controller.tabController.index == 0
                    ? signupViews.first
                    : signupViews.last
              ]),
            )
          ],
        ),
      )),
    );
  }
}
