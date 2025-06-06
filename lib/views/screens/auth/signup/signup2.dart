import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/static/auth.dart';
import 'package:afrahdz/views/widgets/auth/signup2view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup2 extends GetView<LoginController> {
  const Signup2({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final height = AppSize.appheight;
    final width = AppSize.appwidth;
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: height,
        width: width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: width * .08, vertical: 20),
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                  backgroundColor: Appcolors.primaryColor,
                ))
              : Stack(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "SignupTitle1".tr,
                            style: const TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w700),
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
                        SizedBox(
                          height: height * .67,
                          width: width,
                          child: Column(children: [
                            controller.tabController.index == 0
                                ? Signup2view(
                                    text: "SignupClientHeader".tr,
                                    isMember: false,
                                  )
                                : Signup2view(
                                    text: "SignupMemberHeader".tr,
                                    isMember: true,
                                  ),
                          ]),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: ShapeDecoration(
                            shape: const CircleBorder(eccentricity: 0),
                            gradient: Appcolors.backbuttonGradient),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      )),
    );
  }
}
