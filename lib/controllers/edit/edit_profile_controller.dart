import 'dart:io';

import 'package:afrahdz/core/services/auth_service.dart';
import 'package:afrahdz/core/services/homepage_service.dart';
import 'package:afrahdz/data/models/user.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfileController extends GetxController {
  HomepageService homepageService = HomepageService();
  final Rx<UserModel?> userDetails = Rx<UserModel?>(null);
  late bool isMemberLoggedIn;
  AuthService authService = AuthService();
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;

  DateTime? selectedDate;
  String? selectedWilaya;
  var selectedImage = Rx<File?>(null);

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController fixeController;
  late TextEditingController agecontroller;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade800, // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Calendar background color
              onSurface: Colors.black, // Calendar text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      isLoading(true);
      final user = await homepageService.getUserDetails(isMemberLoggedIn);
      if (user != null) {
        userDetails.value = user;
      }
    } catch (e) {
      throw Exception("something went wrong");
    } finally {
      isLoading(false);
    }
  }

  Future<void> modifyClient(String clientId) async {
    try {
      isLoading(true);
      await authService.updateClient(
        clientId: int.parse(clientId),
        name: nameController.text == ""
            ? userDetails.value!.name
            : nameController.text,
        wilaya: selectedWilaya == null
            ? userDetails.value!.wilaya
            : selectedWilaya!,
        phone: phoneController.text.isEmpty
            ? userDetails.value!.phone
            : phoneController.text,
        age: agecontroller.text.isEmpty
            ? userDetails.value!.id.toString()
            : agecontroller.text,
      );

      selectedImage.value != null ? await updateClientImage(clientId) : null;
      Get.snackbar('Success', 'Client modifié avec succès');
      // Handle success response
      Get.snackbar('Success', 'Client modifié avec succès');
    } catch (e) {
      Get.snackbar('Erreur', "Impossible de modifier le client maintenant");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateClientImage(String clientId) async {
    try {
      isLoading(true);

      // Pick an image from the gallery or camera

      // Create a Dio instance
      dio.Dio dDio = dio.Dio();

      // Use fully qualified name for FormData (dio.FormData)
      dio.FormData formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(
          selectedImage.value!.path,
          filename:
              '${basename(selectedImage.value!.path)}.jpg', // Optional: specify a filename
        ),
      });
      final String? token = storage.read('token');

      // Send the POST request using Dio
      var response = await dDio.post(
          'https://www.afrahdz.com/api/client/image/update/$clientId',
          data: formData,
          options: dio.Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }, preserveHeaderCase: true));

      // Check the response status
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Image du client mise à jour avec succès');
      } else {
        Get.snackbar(
            'Erreur', 'Impossible de mettre à jour l\'image du client');
      }
    } catch (e) {
      Get.snackbar('Erreur',
          "Impossible de mettre à jour l'image du client: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateMemberImage(String membreId) async {
    try {
      isLoading(true);

      // Pick an image from the gallery or camera

      // Create a Dio instance
      dio.Dio dDio = dio.Dio();
      final String? token = storage.read('token');

      // Use fully qualified name for FormData (dio.FormData)
      dio.FormData formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(
          selectedImage.value!.path,
          filename:
              '${basename(selectedImage.value!.path)}.jpg', // Optional: specify a filename
        ),
      });

      // Send the POST request using Dio
      var response = await dDio.post(
          'https://www.afrahdz.com/api/membre/image/update/$membreId',
          data: formData,
          options: dio.Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }, preserveHeaderCase: true));

      // Check the response status
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      Get.snackbar('Erreur',
          "Impossible de mettre à jour l'image du client: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> modifyMembre(String memberId) async {
    try {
      isLoading(true);
      await authService.updateMembre(
        membreId: int.parse(memberId),
        name: nameController.text,
        wilaya: selectedWilaya ?? userDetails.value!.wilaya,
        phone: phoneController.text,
        fixe: fixeController.text,
        age: agecontroller.text.isEmpty
            ? userDetails.value!.age.toString()
            : agecontroller.text,
      );

      selectedImage.value != null ? await updateMemberImage(memberId) : null;
      Get.snackbar('Success', 'Membre modifié avec succès');

      // Handle success response
    } finally {
      isLoading(false);
    }
  }

  // Function to pick an image from the camera
  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Function to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Function to show the image picker modal bottom sheet
  void showImagePickerModal() {
    Get.bottomSheet(
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Choose from Camera'),
              onTap: () {
                pickImageFromCamera();
                Get.back(); // Close the bottom sheet
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                pickImageFromGallery();
                Get.back(); // Close the bottom sheet
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  void onInit() {
    super.onInit();

    isMemberLoggedIn = Get.arguments['isMember'];
    if (isMemberLoggedIn) {
      fixeController = TextEditingController();
    }
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    agecontroller = TextEditingController();

    fetchUserDetails();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    agecontroller.dispose();
    if (isMemberLoggedIn) {
      fixeController.dispose();
    }
  }
}
