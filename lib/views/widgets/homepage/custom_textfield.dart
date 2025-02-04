import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';

// ignore: must_be_immutable
class CustomTextfield2 extends StatelessWidget {
  final Widget prefixIcon;
  final String hint;
  void Function(String)? search;
  CustomTextfield2(
      {super.key, required this.hint, required this.prefixIcon, this.search});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppSize.appwidth * .05),
      child: TextFormField(
        onFieldSubmitted: search,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Color(0xFFA7A4A4),
          ),
          prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: BorderSide(color: Appcolors.primaryColor)),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReservationTextfield extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? keyboardtype;
  final String hint;
  ReservationTextfield(
      {super.key, required this.hint, this.controller, this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      cursorColor: Appcolors.primaryColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFFA7A4A4),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Appcolors.primaryColor)),
      ),
    );
  }
}
