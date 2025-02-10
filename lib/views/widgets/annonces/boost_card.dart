import 'package:afrahdz/controllers/ad/boost_ad_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/annonces/boost_benefit.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostCard extends GetView<BoostAdController> {
  final bool isVIP;
  final String type, desc;
  final List<String> advantages;
  final double price;
  const BoostCard(
      {super.key,
      required this.isVIP,
      required this.type,
      required this.desc,
      required this.advantages,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .5,
      width: AppSize.appwidth,
      padding: EdgeInsets.symmetric(
          vertical: AppSize.appheight * .02,
          horizontal: AppSize.appwidth * .08),
      margin: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .04),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.grey.withOpacity(.2))),
        shadows: [
          BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isVIP
                  ? Container(
                      alignment: Alignment.center,
                      height: AppSize.appheight * .03,
                      width: AppSize.appwidth * .24,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF4030B2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.93),
                        ),
                      ),
                      child: Text(
                        "MostPopularTag".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.67,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          SizedBox(
            height: AppSize.appheight * .005,
          ),
          GradientText(
            text: type.tr,
            gradient: Appcolors.primaryGradient,
            style: const TextStyle(
              fontSize: 43.53,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            desc,
            style: const TextStyle(
              color: Color(0xE2525252),
              fontSize: 11,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: AppSize.appheight * .01,
          ),
          ...List.generate(
              advantages.length, (i) => BoostBenefit(text: advantages[i])),
          const Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding
                  shadowColor: Colors.black, // Remove default shadow
                  elevation: 4),
              onPressed: () => controller.showBoostOptions(
                  context, price, type.toLowerCase()),
              child: Ink(
                height: AppSize.appheight * .06,
                decoration: BoxDecoration(
                    gradient: Appcolors.primaryGradient,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Boostbtn'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 20,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
