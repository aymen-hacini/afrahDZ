import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BoostBenefit extends StatelessWidget {
  String text;
   BoostBenefit({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.appheight * .01),
      child: Row(
        children: [
          SvgPicture.asset("assets/svg/fillcheck.svg"),
          SizedBox(
            width: AppSize.appwidth * .01,
          ),
          Text(
            text.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
