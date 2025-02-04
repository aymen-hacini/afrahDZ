import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';

class FullDetails extends StatelessWidget {
  final AdModel selectedad;
  const FullDetails({super.key, required this.selectedad});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .17,
      width: AppSize.appwidth,
      padding:
          EdgeInsets.symmetric(horizontal: AppSize.appwidth * .01, vertical: 8),
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurStyle: BlurStyle.normal,
            blurRadius: 4, // Blur intensity
            spreadRadius: 1, // Spread of the shadow
            offset: const Offset(0, 2), // Shadow position (x, y)
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: AppSize.appwidth * .3,
                height: AppSize.appheight * .7,
                child: Image.network(
                  "${ApiLinkNames.server}${selectedad.imageFullPath}",
                  errorBuilder: (context, _, i) => const Center(
                    child: Text("Erreur"),
                  ),
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(width: AppSize.appheight * .02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.appheight * .02,
              ),
              Text(selectedad.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19.98,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  )),
              RatingStars(
                valueLabelMargin: EdgeInsets.zero,
                valueLabelPadding: EdgeInsets.zero,
                value: selectedad.rating,
                onValueChanged: (v) {},
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  size: 14,
                  color: color,
                ),
                starCount: 5,
                maxValue: 5,
                starSize: 14,
                valueLabelTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                maxValueVisibility: false,
                valueLabelVisibility: false,
                starColor: const Color(0xffFBBC05),
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
                    '${selectedad.address} / ${selectedad.city}',
                    style: const TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 9.94,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GradientText(
                text: "${selectedad.price.toStringAsFixed(2)} DA",
                gradient: Appcolors.primaryGradient,
                style: const TextStyle(
                  color: Color(0xFFC628BC),
                  fontSize: 16.28,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Appcolors.primaryColor,
          )
        ],
      ),
    );
  }
}

class FavoritesFulldetails extends StatelessWidget {
  final AdModel selectedad;
  final VoidCallback press;
  const FavoritesFulldetails(
      {super.key, required this.selectedad, required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .17,
      width: AppSize.appwidth * .8,
      padding:
          EdgeInsets.symmetric(horizontal: AppSize.appwidth * .01, vertical: 8),
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurStyle: BlurStyle.normal,
            blurRadius: 4, // Blur intensity
            spreadRadius: 1, // Spread of the shadow
            offset: const Offset(0, 2), // Shadow position (x, y)
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: AppSize.appwidth * .3,
                height: AppSize.appheight * .7,
                child: Image.network(
                  "${ApiLinkNames.server}${selectedad.imageFullPath}",
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(width: AppSize.appheight * .02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.appheight * .02,
              ),
              Text(selectedad.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19.98,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  )),
              RatingStars(
                valueLabelMargin: EdgeInsets.zero,
                valueLabelPadding: EdgeInsets.zero,
                value: selectedad.rating,
                onValueChanged: (v) {},
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  size: 14,
                  color: color,
                ),
                starCount: 5,
                maxValue: 5,
                starSize: 14,
                valueLabelTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                maxValueVisibility: false,
                valueLabelVisibility: false,
                starColor: const Color(0xffFBBC05),
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
                    '${selectedad.address} / ${selectedad.city}',
                    style: const TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 9.94,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GradientText(
                text: "${selectedad.price.toStringAsFixed(2)} DA",
                gradient: Appcolors.primaryGradient,
                style: const TextStyle(
                  color: Color(0xFFC628BC),
                  fontSize: 16.28,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: press,
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
              ))
        ],
      ),
    );
  }
}
