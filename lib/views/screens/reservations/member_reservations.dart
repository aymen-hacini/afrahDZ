import 'package:afrahdz/controllers/reservations/member_reservation_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/static/member_reservations.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MemberReservations extends GetView<MemberReservationController> {
  const MemberReservations({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MemberReservationController());
    return SmartRefresher(
      controller: RefreshController(),
      header: WaterDropMaterialHeader(
        backgroundColor: Appcolors.primaryColor,
        color: Colors.white,
      ),
      onRefresh: ()=>controller.fetchReservations(),
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
                          text:"ClientReservaitonsTitle".tr,
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
                      height: AppSize.appheight * .04,
                    ),
                    Center(
                      child: TabBar(
                          tabAlignment: TabAlignment.center,
                          controller: controller.tabController,
                          indicatorColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.zero,
                          indicator: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9)),
                              color: const Color(0x59CF59C7)),
                          dividerHeight: 0,
                          splashBorderRadius: BorderRadius.circular(10),
                          isScrollable: false,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: memberReservationsTabs),
                    ),
                    SizedBox(
                      height: AppSize.appheight * .01,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: memberReservationsViews,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppSize.appheight * .015,
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
            ),
          ),
        ),
      ),
    );
  }
}
