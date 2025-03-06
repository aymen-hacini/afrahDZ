import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/annonces/boost_benefit.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: AppSize.appheight,
        width: AppSize.appwidth,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .04),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: ShapeDecoration(
                        shape: const CircleBorder(eccentricity: 0),
                        gradient: Appcolors.backbuttonGradient),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/images/about.png",
            ),
            GradientText(
              text: "HomepageAboutTile".tr,
              gradient: Appcolors.primaryGradient,
              style: const TextStyle(
                color: Color(0xFFC628BC),
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .02,
            ),
            Text(
              "About1".tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.13,
              ),
            ),
            Text(
              "About2".tr,
              style: const TextStyle(
                color: Color(0xFF525252),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                height: 1.53,
              ),
            ),
            SizedBox(height: AppSize.appheight * .02),
            BoostBenefit(text: "Desc1".tr),
            BoostBenefit(text: "Desc2".tr),
            BoostBenefit(text:"Desc3".tr),
            BoostBenefit(text: "Desc4".tr),
           // ...List.generate(4, (i) => BoostBenefit(text: desc[i].tr))
          ],
        ),
      )),
    );
  }
}
