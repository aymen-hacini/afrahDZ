import 'package:afrahdz/core/services/auth_service.dart';
import 'package:afrahdz/views/screens/auth/forgetpassword/resetpassword.dart';
import 'package:afrahdz/views/screens/auth/login/login.dart';
import 'package:afrahdz/views/screens/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final AuthService authService = AuthService();

  // Observable variables
  var isLoading = false.obs;
  var otpCode = 0.obs; // Store the OTP code received from the API
  int usercode = 0;
  late TextEditingController emailController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  late bool isMemberSelected;

  // Function to send OTP to email
  Future<void> sendOtptoClient() async {
    try {
      isLoading(true); // Start loading

      // Call the service to send OTP
      final int code =
          await authService.sendOtpToEmailClient(emailController.text);
      otpCode.value = code; // Store the OTP code

      Get.snackbar(
          'Success', 'OTP envoyé avec succès!'); // Show success message
      Get.to(
          () => Otp(
                email: emailController.text,
              ),
          transition: Transition.fade); // Navigate to OTP screen
    } catch (e) {
      Get.snackbar('Erreur', "Échec de l'envoi de l'OTP"); // Show Erreur message
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Function to send OTP to email
  Future<void> sendOtptoMember() async {
    try {
      isLoading(true); // Start loading

      // Call the service to send OTP
      final int code =
          await authService.sendOtpToEmailMember(emailController.text);
      otpCode.value = code; // Store the OTP code

      Get.snackbar(
          'Success', 'OTP envoyé avec succès!'); // Show success message
      Get.to(
          () => Otp(
                email: emailController.text,
              ),
          transition: Transition.fade); // Navigate to OTP screen
    } catch (e) {
      Get.snackbar(
          'Erreur', "Échec de l'envoi de l'OTP"); // Show Erreur message
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Function to verify OTP
  void verifyOtp(int enteredOtp) {
    if (enteredOtp == otpCode.value) {
      Get.snackbar('Success', 'OTP vérifié!'); // Show success message
      Get.to(() =>
          const ResetPasswordScreen()); // Navigate to reset password screen
    } else {
      Get.snackbar('Erreur',
          'OTP non valide, veuillez réessayer.'); // Show Erreur message
    }
  }

  void resetPassowrdClient() async {
    if (newPasswordController.text == confirmNewPasswordController.text) {
      try {
        isLoading(true);
        final isResetted = await authService.resetPasswordClient(
            emailController.text, newPasswordController.text);
        if (isResetted) {
          Get.snackbar('Success', 'Password changed successfully!');
          Get.offAll(() => const Login(), transition: Transition.leftToRight);
          Get.delete<ForgetPasswordController>();
        } else {
          Get.snackbar('Error',
              'Impossible de modifier le mot de passe, veuillez réessayer.');
        }
      } catch (e) {
        Get.snackbar('Error',
            'Impossible de modifier le mot de passe, veuillez réessayer.');
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar('Error',
          'Les mots de passe ne correspondent pas, veuillez réessayer');
    }
  }

  void resetPassowrdMember() async {
    if (newPasswordController.text == confirmNewPasswordController.text) {
      try {
        isLoading(true);
        final isResetted = await authService.resetPasswordMember(
            emailController.text, newPasswordController.text);
        if (isResetted) {
          Get.snackbar('Succès', 'Mot de passe modifié avec succès');
          Get.offAll(() => const Login(), transition: Transition.leftToRight);
          Get.delete<ForgetPasswordController>();
        } else {
          Get.snackbar('Erreur',
              'Impossible de modifier le mot de passe, veuillez réessayer.');
        }
      } catch (e) {
        Get.snackbar('Erreur',
            'Impossible de modifier le mot de passe, veuillez réessayer.');
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar('Erreur',
          'Les mots de passe ne correspondent pas, veuillez réessayer');
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    isMemberSelected = Get.arguments['isMemberSelected'];
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
