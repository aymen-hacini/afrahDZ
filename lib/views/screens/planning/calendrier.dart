import 'package:afrahdz/controllers/planning/planning_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/planning/planning_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Planning extends GetView<PlanningController> {
  const Planning({super.key});

  @override
  Widget build(BuildContext context) {
    PlanningController controller =
        Get.put(PlanningController(), permanent: false);
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: Colors.white,
              height: AppSize.appheight,
              width: AppSize.appwidth,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.appheight * .02),
                        child: Center(
                          child: GradientText(
                            text: "PlanningTitle".tr,
                            gradient: Appcolors.primaryGradient,
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    
                      Expanded(child: Obx(
                        () {
                          if (controller.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Appcolors.primaryColor,
                              ),
                            );
                          } else {
                            return controller.plannings.isEmpty
                                ?  Center(
                                    child: Text("NoPlans".tr),
                                  )
                                : ListView.builder(
                                    itemCount: controller.plannings.length,
                                    itemBuilder: (context, index) {
                                      final currentPlanningCard =
                                          controller.plannings[index];
                                      return PlanningCard(
                                          selectedPlanning:
                                              currentPlanningCard);
                                    });
                          }
                        },
                      ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: AppSize.appheight * .01,
                        left: AppSize.appwidth * .045),
                    child: InkWell(
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
                  ),
                ],
              ))),
    );
  }
}
