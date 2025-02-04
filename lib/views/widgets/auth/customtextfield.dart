import 'package:afrahdz/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatelessWidget {
  final String image, hint;
  final TextEditingController controller;
  final TextInputType? keyboardtype;
  const CustomTextField(
      {super.key,
      required this.image,
      required this.hint,
      required this.controller,this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: controller,
        cursorColor: Appcolors.primaryColor,
        keyboardType: keyboardtype,
        decoration: InputDecoration(
            fillColor: const Color(0x33C4C4C4),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 15.91,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
            ),
            hintText: hint,
            suffixIcon: Transform.scale(
              scale: .6,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.contain,
                height: 5,
                width: 5,
              ),
            )),
      ),
    );
  }
}
