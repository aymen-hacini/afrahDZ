import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/contact_service.dart'; // Import the service

class ContactController extends GetxController {
  final ContactService contactService = ContactService();

  // Observable variable to track loading state
  var isLoading = false.obs;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController subjectController;
  late TextEditingController phoneController;
  late TextEditingController messageController;

  // Function to send a "Contact Us" message
  Future<void> sendContactUsMessage() async {
    try {
      isLoading(true); // Start loading



      // Call the service to send the message
      await contactService.sendContactUsMessage(
        email: emailController.text,
        message: messageController.text,
        subject: subjectController.text,
        phone: phoneController.text,
        genre: "default",
        name: nameController.text,
      );

      Get.snackbar(
          'Success', 'Message envoyé avec succès !'); // Show success message
    } catch (e) {
      Get.snackbar('Error', "Échec de l'envoi du message"); // Show error message
    } finally {
      isLoading(false); // Stop loading
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    subjectController = TextEditingController();
    phoneController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    phoneController.dispose();
    messageController.dispose();
  }
}
