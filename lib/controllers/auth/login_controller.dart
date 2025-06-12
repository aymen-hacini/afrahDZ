import 'dart:io';

import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/core/functions/getdevicetoken.dart';
import 'package:afrahdz/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final tabIndex = 0.obs;
  final RxBool isLoading = false.obs; // Track loading state
  var isObscured = true.obs;
  var signupisObscured = true.obs;

  String? selectedWilaya;

  late TabController tabController;

  final AuthService authService = AuthService();
  final GetStorage storage = GetStorage();

  // Observable variable to hold the selected image
  var selectedImage = Rx<File?>(null);

  final RxBool rememberMe = (GetStorage().read('rememberMe') == true).obs;

  // Check if the user is logged in
  bool get isLoggedIn => storage.read('token') != null;
  // Get user type (client or member)
  String? get userType => storage.read('userType');

  //Text editing controllers  for client

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatpasswordController;
  late TextEditingController phoneController;

  //Text editing controllers  for client login

  late TextEditingController clientloginEmailController;
  late TextEditingController clientloginPasswordController;

  //Text editing controllers  for member

  late TextEditingController membercommericalnameController;
  late TextEditingController memberlocationController;
  late TextEditingController memberemailController;
  late TextEditingController memberpasswordController;
  late TextEditingController memberrepeatpasswordController;
  late TextEditingController memberphoneController;
  late TextEditingController memberfixeController;
  late TextEditingController referralCodeController;

  //Text editing controllers  for member login

  late TextEditingController memberloginEmailController;
  late TextEditingController memberloginPasswordController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);

    nameController = TextEditingController();
    ageController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatpasswordController = TextEditingController();
    phoneController = TextEditingController();
    membercommericalnameController = TextEditingController();
    memberemailController = TextEditingController();
    memberpasswordController = TextEditingController();
    memberrepeatpasswordController = TextEditingController();
    memberphoneController = TextEditingController();
    memberfixeController = TextEditingController();
    memberlocationController = TextEditingController();
    referralCodeController = TextEditingController();

    clientloginPasswordController = TextEditingController();
    clientloginEmailController = TextEditingController();

    memberloginPasswordController = TextEditingController();
    memberloginEmailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatpasswordController.dispose();
    phoneController.dispose();

    memberfixeController.dispose();
    memberlocationController.dispose();
    membercommericalnameController.dispose();
    memberemailController.dispose();
    memberpasswordController.dispose();
    memberrepeatpasswordController.dispose();
    memberphoneController.dispose();
    referralCodeController.dispose();

    clientloginPasswordController.dispose();
    clientloginEmailController.dispose();

    memberloginPasswordController.dispose();
    memberloginEmailController.dispose();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
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

  Future<void> signupClient() async {
    String? deviceToken = await getDeviceToken();

    if (passwordController.text == repeatpasswordController.text) {
      try {
        isLoading(true); // Start loading
        final token = await authService.signupClient(
            nameController.text.trim(),
            ageController.text.trim(),
            selectedWilaya ?? "",
            emailController.text.trim(),
            passwordController.text.trim(),
            phoneController.text.trim(),
            selectedImage.value,
            deviceToken!);
        if (token != null) {
          storage.write('token', token); // Store the token in GetStorage
          Get.snackbar('Success', 'Signup successful!');
          Get.offAllNamed(AppRoutesNames.homepage,
              arguments: {"isMember": false}); // Navigate to the home screen
        }
      } catch (e) {
        Get.snackbar('Erreur', e.toString());
      } finally {
        isLoading(false); // stop loading
      }
    } else {
      Get.snackbar(
          'Erreur', 'Le mot de passe ne correspond pas, veuillez réessayer.');
    }
  }

  Future<void> signupMember() async {
    String? deviceToken = await getDeviceToken();

    if (selectedImage.value == null) {
      Get.snackbar('Erreur', 'Veuillez sélectionner une image');
      return;
    }
    if (memberpasswordController.text == memberrepeatpasswordController.text) {
      try {
        isLoading(true); // Start loading
        final token = await authService.signupMember(
            membercommericalnameController.text.trim(),
            memberemailController.text.trim(),
            selectedWilaya ?? "",
            memberlocationController.text.trim(),
            memberfixeController.text.trim(),
            memberphoneController.text.trim(),
            memberpasswordController.text.trim(),
            selectedImage.value,
            code: referralCodeController.text.trim(),
            deviceToken!);
        Get.snackbar('Success', 'Inscription réussie !');
        Get.offAllNamed(AppRoutesNames.homepage,
            arguments: {"isMember": false});

        showSuccessDialog(Get
            .context!); // Show a dialog to inform the user about the email confirmation

        if (token != null) {
          storage.write('token', token); // Store the token in GetStorage
          // Navigate to the home screen
        }
      } catch (e) {
        Get.snackbar('Erreur', e.toString());
      } finally {
        isLoading(false); // stop loading
      }
    } else {
      Get.snackbar(
          'Erreur', 'Le mot de passe ne correspond pas, veuillez réessayer.');
    }
  }

  // Auto-login method
  Future<void> autoLogin() async {
    final rememberMeState = storage.read('rememberMe') ?? false;
    if (rememberMeState) {
      final email = storage.read('email');
      final password = storage.read('password');
      final userType = storage.read('userType'); // Get stored user type

      if (email != null && password != null && userType != null) {
        await login(email, password, userType);
        return;
      }
    } else {
      // If no token is found, redirect to the login page
      storage.remove('token'); // Clear any existing token
      storage.remove('email'); // Clear stored email
      storage.remove('password'); // Clear stored password
      storage.remove('userType'); // Clear stored user type
      storage.remove('rememberMe'); // Clear "Remember Me" state
      // Redirect to the login page
      Get.offAllNamed(AppRoutesNames.login);
    }
  }

  // Login method
  Future<void> login(String email, String password, String userType) async {
    try {
      String? deviceToken = await getDeviceToken();

      isLoading(true); // Start loading
      final token = userType == "client"
          ? await authService.loginClient(email, password, deviceToken!)
          : await authService.loginMember(email, password, deviceToken!);

      if (token != null) {
        storage.write('token', token); // Store the token in GetStorage

        if (rememberMe.value) {
          // Save email and password if "Remember Me" is checked
          storage.write('email', email);
          storage.write('password', password);
          storage.write('userType', userType);
        } else {
          // Clear saved credentials if "Remember Me" is unchecked
          storage.remove('email');
          storage.remove('password');
          storage.remove('userType');
        }
        storage.write('rememberMe', rememberMe.value);


        // Save the "Remember Me" state
        storage.write('userType', userType);

        Get.snackbar('Success', 'Login successful!');
        Get.offAllNamed(AppRoutesNames.homepage, arguments: {
          "isMember": userType == "client" ? false : true
        }); // Navigate to the home screen
      }
    } catch (e) {
      Get.snackbar('Erreur', "Email ou mot de passe est incorrect");
    } finally {
      isLoading(false); // stop loading
    }
  }

  clearControllers() {
    memberemailController.clear();
    memberpasswordController.clear();
    memberrepeatpasswordController.clear();
    membercommericalnameController.clear();
    memberfixeController.clear();
    memberphoneController.clear();
    memberlocationController.clear();
    memberloginEmailController.clear();
    memberloginPasswordController.clear();
    clientloginEmailController.clear();
    clientloginPasswordController.clear();
    nameController.clear();
    ageController.clear();
    emailController.clear();
    passwordController.clear();
    repeatpasswordController.clear();
    phoneController.clear();
  }

  void toggleObscure() {
    isObscured.value = !isObscured.value;
  }

  void togglesignupObscure() {
    signupisObscured.value = !signupisObscured.value;
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Succès"),
      content: Text(
        "Veuillez patienter jusqu'à ce que votre demande de compte membre soit acceptée. Merci pour votre patience."
            .tr,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
