import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/controllers/contact/contact_controller.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact extends GetView<ContactController> {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ContactController());
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.appwidth * .04,
            vertical: AppSize.appheight * .02),
        height: AppSize.appheight,
        width: AppSize.appwidth,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.appheight * .01),
                  child: Center(
                    child: GradientText(
                      text: "ContactTitle".tr,
                      gradient: Appcolors.primaryGradient,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ContactHeader".tr,
                    style: const TextStyle(
                      color: Color(0xDD525252),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.88,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.appheight * .03,
                ),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Text(
                        "EditprofileName".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.88,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        controller: controller.nameController,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.88,
                        ),
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "Nom",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        'EditprofileEmail'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.88,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        controller: controller.emailController,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.88,
                        ),
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "example@gmail.com",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        "ContactSubject".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.88,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        controller: controller.subjectController,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.88,
                        ),
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "Example sujet",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        'EditprofilePhone'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.88,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        controller: controller.phoneController,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.88,
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "055 00 55 55",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      Text(
                        'AdDescription'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.88,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .01,
                      ),
                      TextFormField(
                        controller: controller.messageController,
                        maxLines: 8,
                        style: const TextStyle(
                          color: Color(0xFF534C4C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.88,
                        ),
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "...",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      SizedBox(
                        height: AppSize.appheight * .15,
                      ),
                      Obx(
                        () => AnimatedContainer(
                          duration: 300.milliseconds,
                          margin: EdgeInsets.symmetric(
                            horizontal: controller.isLoading.value
                                ? AppSize.appwidth * .3
                                : 0,
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // Remove default padding
                                  shadowColor:
                                      Colors.black, // Remove default shadow
                                  elevation: 4),
                              onPressed: () =>
                                  controller.sendContactUsMessage(),
                              child: Ink(
                                height: AppSize.appheight * .06,
                                decoration: BoxDecoration(
                                    gradient: Appcolors.primaryGradient,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator
                                          .adaptive(
                                          backgroundColor: Colors.white,
                                        )
                                      : Text(
                                          "ContactBtn".tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFFFBFBFB),
                                            fontSize: 20,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 40,
                width: 40,
                decoration: ShapeDecoration(
                    shape: const CircleBorder(eccentricity: 0),
                    gradient: Appcolors.backbuttonGradient),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
