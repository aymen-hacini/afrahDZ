import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GenericServiceCard extends StatelessWidget {
  final AdModel selectedAd;
  const GenericServiceCard({super.key, required this.selectedAd});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .4,
      width: AppSize.appwidth * .6,
      padding: const EdgeInsets.symmetric(vertical: 2),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              blurStyle: BlurStyle.normal,
              blurRadius: 10, // Blur intensity
              spreadRadius: 1, // Spread of the shadow
              offset: const Offset(0, 2), // Shadow position (x, y)
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          color: Colors.white),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: AppSize.appheight * .2,
                      width: AppSize.appwidth * .59,
                      child: Image.network(
                        "${ApiLinkNames.serverimage}${selectedAd.imageFullPath}",
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              SizedBox(height: AppSize.appheight * .02),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.locale!.languageCode == "ar"
                      ? 0
                      : AppSize.appwidth * .03,
                  right: Get.locale!.languageCode == "ar"
                      ? AppSize.appwidth * .03
                      : 0,
                ),
                child: Text(
                  selectedAd.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.locale!.languageCode == "ar"
                      ? 0
                      : AppSize.appwidth * .01,
                  right: Get.locale!.languageCode == "ar"
                      ? AppSize.appwidth * .01
                      : 0,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(AppImages.minilocationIcon),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      selectedAd.city,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: AppSize.appheight * .025,
            right: Get.locale!.languageCode == "ar"
                ? AppSize.appwidth * 0.45
                : AppSize.appwidth * .02,
            child: RatingStars(
              valueLabelMargin: EdgeInsets.zero,
              valueLabelPadding: EdgeInsets.zero,
              value: selectedAd.rating,
              onValueChanged: (v) {},
              starBuilder: (index, color) => const Icon(
                Icons.star,
                size: 14,
                color: Color(0xffFBBC05),
              ),
              starCount: 1,
              maxValue: 5,
              starSize: 14,
              valueLabelColor: Colors.transparent,
              valueLabelTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              maxValueVisibility: false,
              valueLabelVisibility: true,
            ),
          ),
        ],
      ),
    );
  }
}
