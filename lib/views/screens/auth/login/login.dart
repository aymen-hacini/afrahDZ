import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final height = AppSize.appheight;
    final width = AppSize.appwidth;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: height,
        width: width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: Column(
          children: [
            SizedBox(
              height: height * .08,
            ),
            Center(
              child: FittedBox(
                child: GradientText(
                  text: "LoginWelcome".tr,
                  gradient: Appcolors.primaryGradient,
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Center(
              child: Text(
                "LoginHeader".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            TabBar(
                tabAlignment: TabAlignment.center,
                controller: controller.tabController,
                indicatorColor: Colors.black,
                indicatorWeight: 2,
                dividerHeight: 0,
                splashBorderRadius: BorderRadius.circular(10),
                isScrollable: false,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                ),
                tabs: tabs),
            SizedBox(
              height: height * .02,
            ),
            Expanded(
              // height: height * .5,
              // width: width,
              child: TabBarView(
                  controller: controller.tabController, children: views),
            )
          ],
        ),
      )),
    );
  }
}
