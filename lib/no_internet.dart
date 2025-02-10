import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NoInternetTitle".tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove default padding
                    shadowColor: Colors.black, // Remove default shadow
                    elevation: 4),
                onPressed: () => Get.offAllNamed(AppRoutesNames.homepage,
                    arguments: {"isMember": false}),
                child: Ink(
                  height: 60,
                  decoration: BoxDecoration(
                      gradient: Appcolors.primaryGradient,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      "TryAgainbtn".tr,
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
          ],
        ),
      ),
    );
  }
}
