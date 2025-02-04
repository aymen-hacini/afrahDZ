import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';

class GenericServiceCard extends StatelessWidget {
  final AdModel selectedAd;
  const GenericServiceCard({super.key, required this.selectedAd});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .4,
      width: AppSize.appwidth * .6,
      padding: const EdgeInsets.symmetric(vertical: 4),
      margin: const EdgeInsets.symmetric(vertical: 8),
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
                        "${ApiLinkNames.server}${selectedAd.imageFullPath}",
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              SizedBox(height: AppSize.appheight * .02),
              Padding(
                padding: EdgeInsets.only(left: AppSize.appwidth * .03),
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
                padding: EdgeInsets.only(left: AppSize.appwidth * .01),
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
            right: 10,
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
