import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorieCard extends StatelessWidget {
  final CategorieModel selectedCat;
  const CategorieCard({super.key, required this.selectedCat});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .3,
      width: AppSize.appwidth,
      margin: EdgeInsets.symmetric(
          horizontal: AppSize.appwidth * .02,
          vertical: AppSize.appheight * .02),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "${ApiLinkNames.serverimage}${selectedCat.image}"))),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: AppSize.appheight * .15,
            decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.0)
                    ],
                    begin: AlignmentDirectional.bottomCenter,
                    end: AlignmentDirectional.topCenter)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSize.appheight * .02,
                    horizontal: AppSize.appwidth * .02),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        Get.locale!.languageCode == "ar"
                            ? selectedCat.arabname
                            : selectedCat.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      Get.locale?.languageCode == "ar"
                          ? Icons.keyboard_arrow_left
                          : Icons.keyboard_arrow_right,
                      size: 36,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
