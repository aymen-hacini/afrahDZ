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
              image:
                  NetworkImage("${ApiLinkNames.server}${selectedCat.image}"))),
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
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSize.appwidth * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(10),
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(eccentricity: 0),
                              color: Colors.white),
                          child: Text(
                            selectedCat.number.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSize.appheight * .02,
                    horizontal: AppSize.appwidth * .02),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        selectedCat.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
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
