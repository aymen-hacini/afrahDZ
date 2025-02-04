import 'package:afrahdz/controllers/ad/boost_ad_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/annonces/boost_card.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostAnnonce extends StatelessWidget {
  const BoostAnnonce({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BoostAdController());
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        height: AppSize.appheight,
        width: AppSize.appwidth,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: AppSize.appheight * .025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.appwidth * .045, vertical: 4),
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
                  SizedBox(
                    width: AppSize.appwidth * .1,
                  ),
                  GradientText(
                    text: "Booster une annonce",
                    gradient: Appcolors.primaryGradient,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .01,
            ),
            Expanded(
              child: ListView(
                children: [
                  const BoostCard(
                      isVIP: true,
                      type: 'VIP',
                      desc:
                          'Offre VIP Mariage – Mettez Votre Annonce Sous les Projecteurs !',
                      advantages: [
                        "Mise en Avant sur Notre Page Principale",
                        "Visiteurs 100% Ciblés",
                        "Gagner le temps et publier votre\n annonce a grande echelle",
                        "Partage sur Nos Réseaux Sociaux"
                      ],price: 200000.00,),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  const BoostCard(
                    type: "Gold",
                    desc:
                        "Offre Gold Mariage – Mettez Votre Annonce Sous les Projecteurs !",
                    advantages: [
                      "Mise en Avant sur Notre Page Seconder",
                      "Visiteurs 50% Ciblés"
                    ],
                    isVIP: false,
                    price: 10000.00,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
