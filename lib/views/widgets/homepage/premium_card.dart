import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';

class PremiumCard extends StatelessWidget {
  final String name, image;
  final double rating;
  const PremiumCard(
      {super.key,
      required this.name,
      required this.image,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.appwidth * .65,
      height: AppSize.appheight * .3,
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
          image: DecorationImage(
            image: NetworkImage('${ApiLinkNames.server}$image'),
            fit: BoxFit.cover,
          )),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: AppSize.appheight * .1,
            width: AppSize.appwidth * .65,
            decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(34),
                        bottomRight: Radius.circular(34))),
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(.8),
                      Colors.black.withOpacity(.0)
                    ],
                    begin: AlignmentDirectional.bottomCenter,
                    end: AlignmentDirectional.topCenter)),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(AppImages.premium)),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: AppSize.appheight * .23, left: 14, right: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                RatingStars(
                  value: rating,
                  onValueChanged: (v) {},
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    size: 14,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 14,
                  maxValue: 5,
                  maxValueVisibility: false,
                  valueLabelVisibility: false,
                  animationDuration: const Duration(milliseconds: 400),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: const Color(0xffFBBC05),
                ),
                const Spacer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
