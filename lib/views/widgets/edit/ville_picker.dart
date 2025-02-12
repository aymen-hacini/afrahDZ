import 'package:afrahdz/controllers/ad/create_ad.dart';
import 'package:afrahdz/controllers/ad/edit_annonce_controller.dart';
import 'package:afrahdz/controllers/edit/edit_profile_controller.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProvincePopupMenuButton extends StatefulWidget {
  const ProvincePopupMenuButton({super.key});

  @override
  _ProvincePopupMenuButtonState createState() =>
      _ProvincePopupMenuButtonState();
}

class _ProvincePopupMenuButtonState extends State<ProvincePopupMenuButton> {
  CreateAdController controller = Get.find();

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
        setState(() {
          controller.selectedWilaya = value; // Update the selected province
        });
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
        child: Row(
          children: [
            Text(
              controller.selectedWilaya != null
                  ? '${controller.selectedWilaya}'
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
        ),
      ),
    );
  }
}

class EditAnnonceWilayaPicker extends StatefulWidget {
  const EditAnnonceWilayaPicker({super.key});

  @override
  _EditAnnonceWilayaPickerState createState() =>
      _EditAnnonceWilayaPickerState();
}

class _EditAnnonceWilayaPickerState extends State<EditAnnonceWilayaPicker> {
  EditAnnonceController controller = Get.find();

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
        setState(() {
          controller.selectedWilaya = value; // Update the selected province
        });
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
        child: Row(
          children: [
            Text(
              controller.selectedWilaya != null
                  ? '${controller.selectedWilaya}'
                  : controller.selectedAdDetails.value!.city,
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

class EditProfileCityPicker extends StatefulWidget {
  const EditProfileCityPicker({super.key});

  @override
  _EditProfileCityPickerState createState() => _EditProfileCityPickerState();
}

class _EditProfileCityPickerState extends State<EditProfileCityPicker> {
  EditProfileController controller = Get.find();

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
        setState(() {
          controller.selectedWilaya = value; // Update the selected province
        });
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
        child: Row(
          children: [
            Text(
              controller.selectedWilaya != null
                  ? '${controller.selectedWilaya}'
                  : controller.userDetails.value!.wilaya,
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

class TypeFetePopup extends StatefulWidget {
  const TypeFetePopup({super.key});

  @override
  _TypeFetePopupState createState() => _TypeFetePopupState();
}

class _TypeFetePopupState extends State<TypeFetePopup> {
  CreateAdController controller = Get.find();

  // List of all fetes in Algeria
  final List<String> fetes = const [
    "Marriages",
    "fiançailles",
    "Anniversaires",
    "Henna",
    "circoncision (Thara)",
    "Autre celeberation",
  ];

  @override
  Widget build(BuildContext context) {
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

class EditTypeFetePopup extends StatefulWidget {
  const EditTypeFetePopup({super.key});

  @override
  _EditTypeFetePopupState createState() => _EditTypeFetePopupState();
}

class _EditTypeFetePopupState extends State<EditTypeFetePopup> {
  EditAnnonceController controller = Get.find();

  // List of all fetes in Algeria
  final List<String> fetes = const [
    "Marriages",
    "fiançailles",
    "Anniversaires",
    "Henna",
    "circoncision (Thara)",
    "Autre celeberation",
  ];

  @override
  Widget build(BuildContext context) {
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
                  : controller.selectedAdDetails.value!.eventType,
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

class CategoriePopup extends StatefulWidget {
  const CategoriePopup({super.key});

  @override
  _CategoriePopupState createState() => _CategoriePopupState();
}

class _CategoriePopupState extends State<CategoriePopup> {


  @override
  Widget build(BuildContext context) {
    CreateAdController controller = Get.find();

    return PopupMenuButton<CategorieModel>(
        onSelected: (CategorieModel value) {
          // Update the selected category in the controller
          setState(() {
            controller.selectedCategorie = value.name;
          });
        },
        itemBuilder: (BuildContext context) {
          return controller.categories.map((CategorieModel category) {
            return PopupMenuItem<CategorieModel>(
              value: category,
              child: Text(Get.locale!.languageCode == "ar" ? category.arabname : category.name), // Display the category name
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
                controller.selectedCategorie != null
                    ? controller.selectedCategorie!
                    // Display the selected category name
                    : 'chooseCategory'.tr,
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
        ));
  }
}

class EditCategoriePopup extends GetView<EditAnnonceController> {
  const EditCategoriePopup({super.key});

// List of all fetes in Algeria
  final List<String> categories = const [
    "Salle des fetes",
    "Negafats",
    "Automobiles",
    "Dj",
    "Sévérité et robes",
    "Bonbons et gâteaux de mariage",
    "Groupes de musique",
    "Groupes de motards",
    "voyage de noces",
    "Costumes",
    "Costumes du marié",
    "Appareil photo et photographie",
    "Chef professionnel",
    "Coiffure et beauté",
    "Burnous et chevaux",
    "Décoration et fleurs",
    "Hôtels et chambres pour la nuit de noces",
    "Bijoux accessoires",
    "Pas de groupe de photographie",
    "Trousseau",
    "Organisateur de fêtes"
  ];
  @override
  Widget build(BuildContext context) {
    EditAnnonceController controller = Get.find();

    return PopupMenuButton<CategorieModel>(
      onSelected: (CategorieModel value) {
        // Update the selected category in the controller
        controller.selectedCategorie = value.name;
      },
      itemBuilder: (BuildContext context) {
        return controller.categories.map((CategorieModel category) {
          return PopupMenuItem<CategorieModel>(
            value: category,
            child: Text(Get.locale!.languageCode == "ar" ? category.arabname : category.name), // Display the category name
          );
        }).toList();
      },
      child: Obx(() {
        return Container(
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
                controller.selectedCategorie != null
                    ? controller.selectedCategorie!
                    // Display the selected category name
                    : controller.selectedAdDetails.value!.category,
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
        );
      }),
    );
  }
}
