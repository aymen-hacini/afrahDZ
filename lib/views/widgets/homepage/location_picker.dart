import 'package:afrahdz/controllers/homepage/homepage_controller.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPicker extends StatelessWidget {
  LocationPicker({super.key});

  final HomePageController homepageController = Get.find();

  // List of all provinces in Algeria
  final List<String> provinces = const [
    "choosewilaya",
    "Adrar",
    "Chlef",
    "Laghouat",
    "Oum_El_Bouaghi",
    "Batna",
    "Bejaia",
    "Biskra",
    "Bechar",
    "Blida",
    "Bouira",
    "Tamanrasset",
    "Tebessa",
    "Tlemcen",
    "Tiaret",
    "Tizi_Ouzou",
    "Alger",
    "Djelfa",
    "Jijel",
    "Setif",
    "Saida",
    "Skikda",
    "Sidi_Bel_Abbes",
    "Annaba",
    "Guelma",
    "Constantine",
    "Medea",
    "Mostaganem",
    "MSila",
    "Mascara",
    "Ouargla",
    "Oran",
    "El_Bayadh",
    "Illizi",
    "Bordj_Bou_Arreridj",
    "Boumerdes",
    "El_Tarf",
    "Tindouf",
    "Tissemsilt",
    "El_Oued",
    "Khenchela",
    "Souk_Ahras",
    "Tipaza",
    "Mila",
    "Ain_Defla",
    "Naama",
    "Ain_Temouchent",
    "Ghardaia",
    "Relizane",
    "Timimoun",
    "Bordj_Badji_Mokhtar",
    "Ouled_Djellal",
    "Beni_Abbes",
    "In_Salah",
    "In_Guezzam",
    "Touggourt",
    "Djanet",
    "El_MGhair",
    "El_Meniaa",
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        homepageController.selectedWilaya.value = value == "choosewilaya"
            ? ""
            : value; // Update the selected province
      },
      itemBuilder: (BuildContext context) {
        return provinces.map((String province) {
          return PopupMenuItem<String>(
            value: province,
            child: Text("${provinces.indexOf(province) + 1}- ${province.tr}"),
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
                      ? homepageController.selectedWilaya.value.tr
                      : 'choosewilaya'.tr,
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

class EventPicker extends StatelessWidget {
  EventPicker({super.key});

  final HomePageController homepageController = Get.find();

  // List of all provinces in Algeria
  final List<String> fetes = const [
    "chooseEvent",
    "Mariage",
    "Fatha",
    "Anniversaires",
    "Hanna",
    "Khtana",
    "Autres",
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        homepageController.selectedFete.value =
            value == "chooseEvent" ? "" : value; // Update the selected province
      },
      itemBuilder: (BuildContext context) {
        return fetes.map((String fete) {
          return PopupMenuItem<String>(
            value: fete,
            child: Text(fete.tr),
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
                  homepageController.selectedFete.value.isNotEmpty
                      ? homepageController.selectedFete.value.tr
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
            )),
      ),
    );
  }
}
