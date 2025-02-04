import 'dart:ui';

import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Future<dynamic> showFelictations() {
  return Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(.5),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(51),
              topRight: Radius.circular(51))),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .04),
          height: AppSize.appheight * .6,
          width: AppSize.appwidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: AppSize.appheight * .004,
                  width: AppSize.appwidth * .2,
                  decoration: ShapeDecoration(
                      gradient: Appcolors.primaryGradient,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              SizedBox(
                height: AppSize.appheight * .01,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Félicitations ! ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset("assets/svg/congrats.svg"),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.appheight * .03,
              ),
              Center(child: SvgPicture.asset("assets/svg/bigcheck.svg")),
              SizedBox(
                height: AppSize.appheight * .01,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '           Votre achat a été validé avec ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'succès',
                      style: TextStyle(
                        color: Color(0xFFC628BC),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '.\nVotre ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'annonce',
                      style: TextStyle(
                        color: Color(0xFFC628BC),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' sera désormais promue selon les conditions de l’offre sélectionnée. Merci de votre confiance !',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: AppSize.appheight * .04),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shadowColor: Colors.black, // Remove default shadow
                        elevation: 4),
                    onPressed: () {
                      Get.back();
                    },
                    child: Ink(
                      height: AppSize.appheight * .06,
                      decoration: BoxDecoration(
                          gradient: Appcolors.primaryGradient,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Terminer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFBFBFB),
                              fontSize: 20,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ));
}
