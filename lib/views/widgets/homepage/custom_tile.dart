import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTile extends StatelessWidget {
  final String title, svg;
  final VoidCallback ontap;
  const CustomTile({
    super.key,
    required this.title,
    required this.svg, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: SvgPicture.asset(svg),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 0.88,
        ),
      ),
    );
  }
}
