import 'package:afrahdz/controllers/ad/create_ad.dart';
import 'package:afrahdz/controllers/ad/edit_annonce_controller.dart';
import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/controllers/edit/edit_profile_controller.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        setState(() {
          controller.selectedWilaya = value; // Update the selected province
        });
      },
      itemBuilder: (BuildContext context) {
        return provinces.map((String province) {
          return PopupMenuItem<String>(
            value: province,
            child: Text(province.tr),
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
                  ? '${controller.selectedWilaya?.tr}'
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
        setState(() {
          controller.selectedWilaya = value; // Update the selected province
        });
      },
      itemBuilder: (BuildContext context) {
        return provinces.map((String province) {
          return PopupMenuItem<String>(
            value: province,
            child: Text(province.tr),
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
                  ? '${controller.selectedWilaya?.tr}'
                  : controller.selectedAdDetails.value!.city.tr,
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
        setState(() {
          controller.selectedWilaya = value; // Update the selected province
        });
      },
      itemBuilder: (BuildContext context) {
        return provinces.map((String province) {
          return PopupMenuItem<String>(
            value: province,
            child: Text(province.tr),
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
                  ? controller.selectedWilaya!.tr
                  : controller.userDetails.value!.wilaya.tr,
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
        setState(() {
          controller.selectedFete = value; // Update the selected fete
        });
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
        child: Row(
          children: [
            Text(
              controller.selectedFete != null
                  ? controller.selectedFete!.tr
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
        setState(() {
          controller.selectedFete = value; // Update the selected fete
        });
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
        child: Row(
          children: [
            Text(
              controller.selectedFete != null
                  ? controller.selectedFete!.tr
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
            controller.selectedCategoriearab = value.arabname;
          });
        },
        itemBuilder: (BuildContext context) {
          return controller.categories.map((CategorieModel category) {
            return PopupMenuItem<CategorieModel>(
              value: category,
              child: Text(Get.locale!.languageCode == "ar"
                  ? category.arabname
                  : category.name), // Display the category name
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
                    ? Get.locale?.languageCode == "ar"
                        ? controller.selectedCategoriearab!
                        : controller.selectedCategorie!
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
    "Salle-Des-Fetes",
    "NEGAFETTE",
    "Location-de-Voiture",
    "DJ",
    "CHEDDA-et-ROBES",
    "Patisserie-et-Gateaux",
    "Karkabou-et-Groupes",
    "Groupes-Motos",
    "Voyage-de-Noces",
    "COSTUME-HOMME",
    "Camera-et-photographe",
    "Chef-Cuisinier",
    "Coiffure-et-Esthetique",
    "Cheval-et-Bernous",
    "Decorations-et-Fleurs",
    "Hotels-et-Nuit-de-Noces",
    "Bijoux-et-Accessoires",
    "groupes-photos-interdits",
    "jhaz",
    "organisateur"
  ];
  @override
  Widget build(BuildContext context) {
    EditAnnonceController controller = Get.find();

    return PopupMenuButton<CategorieModel>(
      onSelected: (CategorieModel value) {
        // Update the selected category in the controller
        controller.selectedCategorie = value.name;
        controller.selectedCategoriearab = value.arabname;
      },
      itemBuilder: (BuildContext context) {
        return controller.categories.map((CategorieModel category) {
          return PopupMenuItem<CategorieModel>(
            value: category,
            child: Text(Get.locale!.languageCode == "ar"
                ? category.arabname
                : category.name), // Display the category name
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
                    ? Get.locale?.languageCode == "ar"
                        ? controller.selectedCategoriearab!
                        : controller.selectedCategorie!
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

class SignupWilayapicker extends StatefulWidget {
  const SignupWilayapicker({super.key});

  @override
  _SignupWilayapickerState createState() => _SignupWilayapickerState();
}

class _SignupWilayapickerState extends State<SignupWilayapicker> {
  LoginController controller = Get.find();

  // List of all provinces in Algeria
  final List<String> provinces = const [
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
        setState(() {
          controller.selectedWilaya = value; // Update the selected province
        });
      },
      itemBuilder: (BuildContext context) {
        return provinces.map((String province) {
          return PopupMenuItem<String>(
            value: province,
            child: Text(province.tr),
          );
        }).toList();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .02),
        width: AppSize.appwidth,
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.appwidth * .03, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0x33C4C4C4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              controller.selectedWilaya != null
                  ? controller.selectedWilaya!.tr
                  : Get.locale?.languageCode == "ar"
                      ? "اختر ولاية"
                      : "Selectionner une wilaya",
              style: const TextStyle(
                color: Color(0xFF534C4C),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0.88,
              ),
            ),
            const Spacer(),
            Transform.scale(
              scale: 1,
              child: SvgPicture.asset(
                AppImages.locationIcon,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
