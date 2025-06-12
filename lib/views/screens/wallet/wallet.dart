import 'dart:ui';

import 'package:afrahdz/controllers/wallet/wallet_controller.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/color.dart';

class Wallet extends GetView<WalletController> {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletController());
    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, size) {
      return SizedBox(
          height: size.maxHeight,
          width: size.maxWidth,
          child: Stack(
            children: [
              ListView(children: [
                Padding(
                  padding: EdgeInsets.only(top: size.maxHeight * .02),
                  child: Center(
                    child: GradientText(
                      text: "Invitez et gagnez des points".tr,
                      gradient: Appcolors.primaryGradient,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.maxHeight * .03,
                ),
                Container(
                  height: size.maxHeight * .22,
                  width: size.maxWidth,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: size.maxWidth * .04),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.maxWidth * .04,
                      vertical: size.maxHeight * .02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xff2B2740),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child:
                                SvgPicture.asset("assets/svg/walletgraph.svg")),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          textAlign: Get.locale!.languageCode == "ar"
                              ? TextAlign.right
                              : TextAlign.left,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Recevez '.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.28,
                                ),
                              ),
                              TextSpan(
                                text: '1 point'.tr,
                                style: const TextStyle(
                                  color: Color(0xFFBD2BBD),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.28,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' dès qu’un ami rejoint via votre code.\nÀ '
                                        .tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.28,
                                ),
                              ),
                              TextSpan(
                                text: '10 points'.tr,
                                style: const TextStyle(
                                  color: Color(0xFFC229BC),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.28,
                                ),
                              ),
                              TextSpan(
                                text: ', un boost gratuit vous attend !'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.maxHeight * .04,
                ),
                controller.codeuse >= 10
                    ? UseBoostCard(controller: controller, size: size)
                    : PointsCard(
                        controller: controller,
                        size: size,
                      ),
                SizedBox(
                  height: size.maxHeight * .04,
                ),
                Container(
                  height: size.maxHeight * .22,
                  width: size.maxWidth,
                  margin: EdgeInsets.symmetric(horizontal: size.maxWidth * .04),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.maxWidth * .04,
                      vertical: size.maxHeight * .02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xff2B2740),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child:
                                SvgPicture.asset("assets/svg/walletgraph.svg")),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Votre code de parrainage'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Partagez ce code avec vos amis. Ils devront le saisir lors de leur inscription.'
                                .tr,
                            style: TextStyle(
                              color: Colors.white.withOpacity(.75),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: size.maxHeight * .02,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  enabled: true,
                                  readOnly: true,
                                  initialValue: controller.code,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    suffix: GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: controller.code));
                                        // Optional: show a confirmation
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Code copié dans le presse-papiers"
                                                      .tr)),
                                        );
                                      },
                                      child: Text("Copier".tr,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white
                                                  .withOpacity(.9))),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.maxWidth * .02,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Remove default padding
                                        shadowColor: Colors
                                            .black, // Remove default shadow
                                        elevation: 4),
                                    onPressed: () {
                                      SharePlus.instance.share(ShareParams(
                                          subject: "Parrainage Afrah",
                                          title: "Parrainage Afrah",
                                          text:
                                              'Salut ! Rejoins-moi sur Afrah et utilise mon code de parrainage ${controller.code} pour gagner 1 point ! https://play.google.com/store/apps/details?id=com.afrahdz1&pcampaignid=web_share'));
                                    },
                                    child: Ink(
                                      height: AppSize.appheight * .06,
                                      decoration: BoxDecoration(
                                          gradient: Appcolors.primaryGradient,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          'Inviter'.tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFFFBFBFB),
                                            fontSize: 16,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSize.appheight * .012,
                    horizontal: AppSize.appwidth * .03),
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
            ],
          ));
    })));
  }
}

class PointsCard extends StatelessWidget {
  final BoxConstraints size;
  const PointsCard({
    super.key,
    required this.controller,
    required this.size,
  });

  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.maxHeight * .22,
        width: size.maxWidth,
        margin: EdgeInsets.symmetric(horizontal: size.maxWidth * .04),
        padding: EdgeInsets.symmetric(
            horizontal: size.maxWidth * .04, vertical: size.maxHeight * .02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0x63EEC5EC),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Vous avez".tr),
            SizedBox(
              height: size.maxHeight * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${controller.codeuse}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                    )),
                SizedBox(
                  width: size.maxWidth * .02,
                ),
                SvgPicture.asset("assets/svg/wallet.svg"),
              ],
            ),
            SizedBox(
              height: size.maxHeight * .02,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Plus que '.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      height: 1.28,
                    ),
                  ),
                  TextSpan(
                    text: '${10 - controller.codeuse} pts ',
                    style: const TextStyle(
                      color: Color(0xFFB72CBF),
                      fontSize: 14,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      height: 1.28,
                    ),
                  ),
                  TextSpan(
                    text: ' pour débloquer votre boost gratuit'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      height: 1.28,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}

class UseBoostCard extends StatelessWidget {
  final BoxConstraints size;
  const UseBoostCard({
    super.key,
    required this.controller,
    required this.size,
  });

  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.maxHeight * .22,
      width: size.maxWidth,
      margin: EdgeInsets.symmetric(horizontal: size.maxWidth * .04),
      padding: EdgeInsets.symmetric(
          horizontal: size.maxWidth * .04, vertical: size.maxHeight * .02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0x63EEC5EC),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            textAlign: Get.locale!.languageCode == "ar"
                ? TextAlign.right
                : TextAlign.left,
            TextSpan(
              children: [
                TextSpan(
                  text: 'Félicitations ! \nVous avez gagné un '.tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.28,
                  ),
                ),
                TextSpan(
                  text: 'boost gratuit '.tr,
                  style: const TextStyle(
                    color: Color(0xFFBC2BBE),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.28,
                  ),
                ),
                const TextSpan(
                  text: '!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Utilisez-le pour mettre en avant l’une de vos publications.'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.28,
            ),
          ),
          SizedBox(
            height: size.maxHeight * .025,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding
                  shadowColor: Colors.black, // Remove default shadow
                  elevation: 4),
              onPressed: () {
                controller.showBoostOptions(context);
              },
              child: Ink(
                height: AppSize.appheight * .06,
                width: AppSize.appwidth * .5,
                decoration: BoxDecoration(
                    gradient: Appcolors.primaryGradient,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Utiliser mon boost'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFBFBFB),
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
