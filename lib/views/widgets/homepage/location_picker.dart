import 'package:afrahdz/controllers/homepage/homepage_controller.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPicker extends StatelessWidget {
  LocationPicker({super.key});

  final HomePageController homepageController = Get.find();

  // List of all provinces in Algeria
  final List<String> provinces = const [
    "Adrar",
    "Chlef",
    "Laghouat",
    "Oum El Bouaghi",
    "Batna",
    "Béjaïa",
    "Biskra",
    "Béchar",
    "Blida",
    "Bouira",
    "Tamanrasset",
    "Tébessa",
    "Tlemcen",
    "Tiaret",
    "Tizi Ouzou",
    "Algiers",
    "Djelfa",
    "Jijel",
    "Sétif",
    "Saïda",
    "Skikda",
    "Sidi Bel Abbès",
    "Annaba",
    "Guelma",
    "Constantine",
    "Médéa",
    "Mostaganem",
    "M'Sila",
    "Mascara",
    "Ouargla",
    "Oran",
    "El Bayadh",
    "Illizi",
    "Bordj Bou Arréridj",
    "Boumerdès",
    "El Tarf",
    "Tindouf",
    "Tissemsilt",
    "El Oued",
    "Khenchela",
    "Souk Ahras",
    "Tipaza",
    "Mila",
    "Aïn Defla",
    "Naâma",
    "Aïn Témouchent",
    "Ghardaïa",
    "Relizane",
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        homepageController.selectedWilaya.value =
            value; // Update the selected province
      },
      itemBuilder: (BuildContext context) {
        return provinces.map((String province) {
          return PopupMenuItem<String>(
            value: province,
            child: Text(province),
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
        child: Obx(() => Row(
              children: [
                Text(
                  homepageController.selectedWilaya.value.isNotEmpty
                      ? homepageController.selectedWilaya.value
                      : 'Selectioner votre willaya',
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
            )),
      ),
    );
  }
}
