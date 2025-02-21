import 'dart:io';

import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/core/services/categorie_service.dart';
import 'package:afrahdz/core/services/homepage_service.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:afrahdz/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CreateAdController extends GetxController {
  final CategorieService categoryService = CategorieService();
  final HomepageService homepageService = HomepageService();
  final AdService adService = AdService();
  final ImagePicker picker = ImagePicker();
  final Rx<UserModel?> userDetails = Rx<UserModel?>(null);
  String? selectedFete;
  String? selectedCategorie;
  String? selectedCategoriearab;
  String? selectedWilaya;

  var currentContainerPageIndex = 0.obs; // Track current page index

  // Observable variables
  var images = <File>[].obs; // All selected images
  var video = Rxn<File?>();

  late TextEditingController nomAnnoncecontroller;
  late TextEditingController addressController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  final RxBool isLoading = false.obs;
  final categories = <CategorieModel>[].obs;
  var videoController = Rxn<VideoPlayerController>();

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
    fetchCategories();

    nomAnnoncecontroller = TextEditingController();
    addressController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
  }

  Future<void> fetchUserDetails() async {
    try {
      final user = await homepageService.getUserDetails(true);
      if (user != null) {
        userDetails.value = user;
      }
    } catch (e) {
      throw Exception("something went wrong");
    }
  }

  // Fetch categories
  Future<void> fetchCategories() async {
    isLoading(true);
    try {
      final fetchedCategories = await categoryService.fetchAllCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les catégories');
    } finally {
      isLoading(false);
    }
  }

  // Create the ad
  Future<void> createAd() async {
    if (images.isEmpty) {
      Get.snackbar('Erreur'.tr, 'Aderreur2'.tr);
      return;
    }

    isLoading(true);

    try {
      // Split the images: first image goes to 'image', the rest go to 'images'
      final firstImage = images.first;
      final additionalImages = images.sublist(1);
      await adService.createAd(
          firstImage: firstImage,
          additionalImages: additionalImages,
          video: video.value,
          name: nomAnnoncecontroller.text,
          category: selectedCategorie!,
          eventType: selectedFete!,
          city: selectedWilaya!,
          address: addressController.text,
          mobile: userDetails.value!.phone,
          memberID: userDetails.value!.id.toString(),
          price: priceController.text,
          description: descriptionController.text
          );
      Get.snackbar('Success'.tr, 'Adsuccess'.tr);
    } catch (e) {
      Get.snackbar('Erreur'.tr, "Aderreur".tr);
    } finally {
      isLoading(false);
    }
  }



  // Pick all images at once
  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      images.assignAll(pickedFiles.map((file) => File(file.path)).toList());
    }
  }

  // Pick the video
  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video.value = File(pickedFile.path);
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
              title:  Text('Choisir des images'.tr),
              onTap: () {
                pickImages();
                Get.back(); // Close the bottom sheet
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title:  Text('Choisir la vidéo'.tr),
              onTap: () {
                pickVideo();
                Get.back(); // Close the bottom sheet
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void initializeVideoController(File videoFile) async {
    videoController.value = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        videoController.value?.play(); // Auto-play the video
        update();
      });
  }

  void disposeVideoController() {
    videoController.value?.pause();
    videoController.value?.dispose();
    videoController.value = null;
  }

  @override
  void dispose() {
    super.dispose();
    nomAnnoncecontroller.clear();
    addressController.clear();
    priceController.clear();
    descriptionController.clear();
  }
}
