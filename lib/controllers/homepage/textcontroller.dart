import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Textcontroller extends GetxController
    with GetSingleTickerProviderStateMixin {
  // AnimationController to manage the animation
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();

    // Initialize the AnimationController
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Animation duration
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
