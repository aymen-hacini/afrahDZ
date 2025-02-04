import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String text;
  final IconData iconData;
  const InfoTile({
    super.key,
    required this.text,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppSize.appheight * .008,
            horizontal: AppSize.appwidth * .03),
        decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: const Color(0xffF6F6F6)),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 12,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}
