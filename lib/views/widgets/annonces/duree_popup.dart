import 'package:afrahdz/controllers/ad/boost_ad_controller.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DureePopupButton extends StatefulWidget {
  const DureePopupButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DureePopupButtonState createState() => _DureePopupButtonState();
}

class _DureePopupButtonState extends State<DureePopupButton> {
  BoostAdController controller = Get.find();
  // List of all time in Algeria
  final List<String> time = const [
    "1 day",
    "2 days",
    "3 days",
    "7 days",
    "15 days",
    "30 days"
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          final convertedValue = value.split(" ");
          final formattedValue = convertedValue.first;
          controller.selectedduration =
              int.parse(formattedValue); // Update the selected province
        });
      },
      itemBuilder: (BuildContext context) {
        return time.map((String time) {
          return PopupMenuItem<String>(
            value: time,
            child: Text(time),
          );
        }).toList();
      },
      child: Container(
        width: AppSize.appwidth,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Text(
              controller.selectedduration != null
                  ? '${controller.selectedduration} day'
                  : 'Choisir une Durée',
              style: const TextStyle(
                color: Color(0xFF534C4C),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0.88,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
    );
  }
}
