import 'dart:io';

import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/core/services/categorie_service.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:afrahdz/data/models/full_ad_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class EditAnnonceController extends GetxController {
  final CategorieService categoryService = CategorieService();
  final AdService adService = AdService();
  final ImagePicker picker = ImagePicker();
  String? selectedFete;
  String? selectedCategorie;
  String? selectedCategoriearab;
  String? selectedWilaya;
  final selectedAdDetails =
      Rx<FullAdDetails?>(null); // Observable selected ad details

  // Observable variables
  var images = <File>[].obs; // All selected images
  var video = Rxn<File?>();
  var currentContainerPageIndex = 0.obs; // Track current page index
  var videoController = Rxn<VideoPlayerController>();

  late TextEditingController nomAnnoncecontroller;
  late TextEditingController addressController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  final RxBool isLoading = false.obs;
  final categories = <CategorieModel>[].obs;

  late int selectedAd;

  @override
  void onInit() {
    super.onInit();
    nomAnnoncecontroller = TextEditingController();
    addressController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    selectedAd = Get.arguments['selectedAd'];
    fetchFullAdDetails(selectedAd);
  }

  // Function to fetch full ad details by ID
  Future<void> fetchFullAdDetails(int adId) async {
    try {
      isLoading(true); // Set loading to true
      final adDetails = await adService
          .getFullAdDetails(adId); // Call AdService to fetch ad details
      selectedAdDetails.value = adDetails;
    } catch (e) {
      Get.snackbar('Erreur', 'Something Went Wrong');
    } finally {
      isLoading(false); // Set loading to false
      update();
    }
  }

  Future<void> modifyAd(String adId) async {
    try {
      isLoading(true);
      await adService.updateAd(
        adId: int.parse(adId),
        name: nomAnnoncecontroller.text == ""
            ? selectedAdDetails.value!.name
            : nomAnnoncecontroller.text,
        category: selectedCategorie ?? selectedAdDetails.value!.category,
        eventType: selectedFete ?? selectedAdDetails.value!.eventType,
        city: selectedWilaya ?? selectedAdDetails.value!.city,
        address: addressController.text == ""
            ? selectedAdDetails.value!.address
            : addressController.text,
        image: images.first,
        images: images.sublist(1),
        video: video.value,
        price: priceController.text == "" ? selectedAdDetails.value!.price.toString() : priceController.text
      );

      // Handle success response
      Get.snackbar('Success', 'Annonce modifiée avec succès');
    } catch (e) {
      Get.snackbar('Erreur', "Impossible de modifier l'annonce");
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
              title: const Text('Choose pictures'),
              onTap: () {
                pickImages();
                Get.back(); // Close the bottom sheet
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose video'),
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
    videoController.value?.dispose(); // Dispose the video controller
  }
}
