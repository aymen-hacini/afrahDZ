import 'package:afrahdz/controllers/ad/ad_detail.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeFetePopupReservation extends StatefulWidget {
  const TypeFetePopupReservation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TypeFetePopupState createState() => _TypeFetePopupState();
}

class _TypeFetePopupState extends State<TypeFetePopupReservation> {
  // List of all fetes in Algeria
  final List<String> fetes =  [
    "Marriages".tr,
    "fiançailles".tr,
    "Anniversaires".tr,
    "Henna".tr,
    "circoncision (Thara)".tr,
    "Autre celeberation".tr,
  ];

  @override
  Widget build(BuildContext context) {
    AdDetailController controller = Get.find();
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          controller.selectedFete = value; // Update the selected fete
        });
      },
      itemBuilder: (BuildContext context) {
        return fetes.map((String fete) {
          return PopupMenuItem<String>(
            value: fete,
            child: Text(fete),
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
              controller.selectedFete != null
                  ? '${controller.selectedFete}'
                  : 'chooseEvent'.tr,
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
