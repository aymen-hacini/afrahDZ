import 'package:afrahdz/controllers/ad/my_annonces_controller.dart';
import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:afrahdz/views/screens/annonce/edit_annonce.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyAnnonceCard extends StatelessWidget {
  final AdModel selectedAd;
  const MyAnnonceCard({
    super.key,
    required this.selectedAd,
  });

  @override
  Widget build(BuildContext context) {
    MyAnnoncesController myAnnoncesController = Get.find();
    return Container(
      height: AppSize.appheight * .23,
      width: AppSize.appwidth,
      margin: EdgeInsets.symmetric(
          horizontal: AppSize.appwidth * .04,
          vertical: AppSize.appheight * .01),
      padding: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .02),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurStyle: BlurStyle.normal,
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 1)
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Le',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(selectedAd.date),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              selectedAd.type == 'gold'
                  ? const GradientText(
                      text: "Silver",
                      gradient: LinearGradient(
                        end: Alignment.topLeft, // Adjust based on your angle
                        begin:
                            Alignment.bottomRight, // Adjust based on your angle
                        colors: [
                          Color(
                              0xFFF0F0F0), // Example color, replace with actual color
                          Color.fromARGB(255, 157, 157,
                              157), // Example color, replace with actual color
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : selectedAd.type == 'vip'
                      ? const GradientText(
                          text: "Gold",
                          gradient: LinearGradient(
                            end:
                                Alignment.topLeft, // Adjust based on your angle
                            begin: Alignment
                                .bottomRight, // Adjust based on your angle
                            colors: [
                              Color(
                                  0xFFFCC201), // Example color, replace with actual color
                              Color(
                                  0xFFB78628), // Example color, replace with actual color
                            ],
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : const SizedBox.shrink(),
              IconButton(
                onPressed: () => showDeletePopup(context,
                    () => myAnnoncesController.deleteAnnonce(selectedAd)),
                icon: SvgPicture.asset("assets/svg/delete.svg"),
              )
            ],
          ),
          Divider(
            color: Colors.grey.withOpacity(.5),
            thickness: 1,
            indent: AppSize.appwidth * .01,
            endIndent: AppSize.appwidth * .01,
          ),
          SizedBox(
            height: AppSize.appheight * .01,
          ),
          Row(
            children: [
              SizedBox(
                height: AppSize.appheight * .1,
                width: AppSize.appwidth * .22,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "${ApiLinkNames.server}${selectedAd.imageFullPath}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: AppSize.appwidth * .03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedAd.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.minilocationIcon,
                        // ignore: deprecated_member_use
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${selectedAd.address} / ${selectedAd.city}',
                        style: const TextStyle(
                          color: Color(0xFF525252),
                          fontSize: 9.94,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: AppSize.appwidth * .62,
                    child: Row(
                      children: [
                        GradientText(
                          text: "${selectedAd.price.toStringAsFixed(2)} DA",
                          gradient: Appcolors.primaryGradient,
                          style: const TextStyle(
                            fontSize: 16.28,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () => Get.to(const EditAnnonce(),
                                arguments: {"selectedAd": selectedAd.id},
                                transition: Transition.leftToRightWithFade),
                            icon: SvgPicture.asset("assets/svg/edit.svg")),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

void showDeletePopup(BuildContext context, VoidCallback deleteAction) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: AppSize.appheight * .3),
        child: AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/svg/deleteAlert.svg"),
              SizedBox(
                height: AppSize.appheight * .03,
              ),
              const Text(
                'Supprimer annonce',
                style: TextStyle(
                  color: Color(0xFF181D27),
                  fontSize: 15.70,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.56,
                ),
              ),
              SizedBox(
                height: AppSize.appheight * .01,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Êtes-vous sûr de vouloir ',
                      style: TextStyle(
                        color: Color(0xFF535861),
                        fontSize: 12.21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                    TextSpan(
                      text: 'Suprimer votre annonce',
                      style: TextStyle(
                        color: Color(0xFF535861),
                        fontSize: 12.21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.43,
                      ),
                    ),
                    TextSpan(
                      text: '? Cette action ne peut être annulée.',
                      style: TextStyle(
                        color: Color(0xFF535861),
                        fontSize: 12.21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.appwidth * .07,
                      vertical: AppSize.appheight * .01),
                  foregroundColor: Colors.black),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Annulée'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD92D20),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.appwidth * .1,
                      vertical: AppSize.appheight * .01),
                  foregroundColor: Colors.white),
              onPressed: () {
                deleteAction();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OUI'),
            ),
          ],
        ),
      );
    },
  );
}
