
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/annonces/boost_benefit.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final List<String> desc = [
  'Plein de rubriques nécessaires pour vos événements.',
  'Les meilleurs annonces et services dans tous\n les domaines.',
  'Disponible dans tout le territoire national 24H/24H.',
  'Des animations de toutes sortes pour toutes les occasions.',
  'Nous somme disponible également dans Google Play\n et App Store.'
];

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
              text: "A Propos",
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
            const Text(
              'Le 1er App en Algérie\n Spécialisé dans lesFêtes\n et Mariages.',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.13,
              ),
            ),
            const Text(
              "Bienvenue chez Afrahdz - Votre partenaire d'exception pour des moments inoubliables !.\n\nnous donnons vie à vos rêves d'événements exceptionnels. Que vous planifiez un mariage, une fête d'anniversaire, une réception d'entreprise ou tout autre événement spécial, nous sommes là pour vous.\n\nNotre équipe dévouée de nombreux services et partenaires professionnels, travaille en étroite collaboration avec vous pour créer des moments magiques et mémorables. Des mariages élégants aux fêtes festives, nous nous occupons de chaque détail pour que vous puissiez profiter de chaque instant.",
              style: TextStyle(
                color: Color(0xFF525252),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                height: 1.53,
              ),
            ),
            SizedBox(height: AppSize.appheight * .02),
            ...List.generate(4, (i) => BoostBenefit(text: desc[i]))
          ],
        ),
      )),
    );
  }
}
