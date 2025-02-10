import 'package:afrahdz/controllers/reservations/client_reservation_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/reservations/reservation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ClientReservations extends GetView<ClientReservationController> {
  const ClientReservations({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ClientReservationController());
    return SmartRefresher(
      controller: RefreshController(),
      header: WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      child: Scaffold(
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
                    padding: EdgeInsets.only(top: AppSize.appheight * .02),
                    child: Center(
                      child: GradientText(
                        text: "ClientReservaitonsTitle".tr,
                        gradient: Appcolors.primaryGradient,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Appcolors.primaryColor,
                          ),
                        );
                      } else if (controller.reservations.isNotEmpty) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              final reservation =
                                  controller.reservations[index];

                              return ReservationCard(
                                isValidated: reservation.etat,
                                selectedReservation: reservation,
                              );
                            },
                            separatorBuilder: (c, i) => SizedBox(
                                  height: AppSize.appheight * .02,
                                ),
                            itemCount: controller.reservations.length);
                      } else {
                        return Center(child: Text("noreservations".tr));
                      }
                    }),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSize.appheight * .01,
                    horizontal: AppSize.appwidth * .045),
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
          ),
        )),
      ),
    );
  }
}
