import 'dart:typed_data';

import 'package:afrahdz/controllers/planning/planning_controller.dart';
import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/planning.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:afrahdz/views/widgets/homepage/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlanningCard extends GetView<PlanningController> {
  final PlanningModel selectedPlanning;
  const PlanningCard({
    super.key,
    required this.selectedPlanning,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .26,
      width: AppSize.appwidth,
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.appwidth * .04,
        vertical: AppSize.appheight * .02,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.appwidth * .02,
      ),
      decoration: ShapeDecoration(
        color: selectedPlanning.reservation.startDate ==
                DateFormat('yyyy-MM-dd').format(DateTime.now())
            ? const Color.fromARGB(255, 255, 146, 138).withOpacity(.3)
            : selectedPlanning.reservation.startDate ==
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.now().add(const Duration(days: 1)))
                ? Colors.red.withOpacity(.05)
                : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
              color: selectedPlanning.reservation.startDate ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())
                  ? const Color.fromARGB(255, 255, 146, 138).withOpacity(.2)
                  : selectedPlanning.reservation.startDate ==
                          DateFormat('yyyy-MM-dd').format(
                              DateTime.now().add(const Duration(days: 1)))
                      ? Colors.red.withOpacity(.05)
                      : Colors.black.withOpacity(.2),
              blurStyle: BlurStyle.normal,
              blurRadius: 10,
              offset: const Offset(0, 8),
              spreadRadius: 1)
        ],
      ),
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(right: 8, top: 8),
              minTileHeight: 60,
              horizontalTitleGap: 8,
              onTap: () {
                _showReservationDetails(
                    context,
                    selectedPlanning.membre.name,
                    selectedPlanning.membre.city,
                    selectedPlanning.membre.phone,
                    selectedPlanning.membre.email,
                    selectedPlanning.membre.profilePicture!);
              },
              leading: HomepageProfileAvatar(
                profileImage: selectedPlanning.membre.profilePicture!,
                borderSvg: AppImages.avatarNoCamSvg,
                size: 50,
              ),
              title: Text(
                selectedPlanning.membre.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                selectedPlanning.membre.city,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: CircleAvatar(
                radius: 6,
                backgroundColor: selectedPlanning.reservation.etat == 'attente'
                    ? Colors.yellow
                    : selectedPlanning.reservation.etat == 'active'
                        ? Colors.green
                        : selectedPlanning.reservation.etat == 'inactive'
                            ? Colors.red
                            : Colors.yellow,
              ),
            ),
            Divider(
              color: const Color(0xFFC628BC),
              thickness: 1,
              indent: AppSize.appwidth * .01,
              endIndent: AppSize.appwidth * .01,
            ),
            SizedBox(
              height: AppSize.appheight * .01,
            ),
            Row(
              children: [
                SizedBox(
                  height: AppSize.appheight * .1,
                  width: AppSize.appwidth * .22,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "${ApiLinkNames.server}${selectedPlanning.annonce.imageFullPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: AppSize.appwidth * .03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedPlanning.annonce.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.minilocationIcon,
                          // ignore: deprecated_member_use
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${selectedPlanning.annonce.address} / ${selectedPlanning.annonce.city}",
                          style: const TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 9.94,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppSize.appwidth * .62,
                      child: GradientText(
                        text:
                            "${selectedPlanning.annonce.price.toStringAsFixed(2)} DA",
                        gradient: Appcolors.primaryGradient,
                        style: const TextStyle(
                          fontSize: 16.28,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: AppSize.appheight * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/svg/check.svg",
                  height: 18,
                  width: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  selectedPlanning.reservation.startDate ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())
                      ? "Today".tr
                      : selectedPlanning.reservation.startDate ==
                              DateFormat('yyyy-MM-dd').format(
                                  DateTime.now().add(const Duration(days: 1)))
                          ? "Tommorow".tr
                          : selectedPlanning.reservation.startDate,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _showReservationDetails(BuildContext context, String name, String address,
    String phone, String email, Uint8List profileImage) {
  Get.dialog(Container(
    margin: EdgeInsets.symmetric(vertical: AppSize.appheight * .25),
    child: AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomepageProfileAvatar(
            profileImage: profileImage,
            borderSvg: AppImages.avatarNoCamSvg,
            size: 90,
          ),
          SizedBox(
            height: AppSize.appheight * .03,
          ),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF181D27),
              fontSize: 15.70,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.56,
            ),
          ),
          SizedBox(
            height: AppSize.appheight * .02,
          ),
          Text(
            address,
            style: const TextStyle(
              color: Color(0xFF535861),
              fontSize: 12.21,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: AppSize.appheight * .02,
          ),
          Text(
            phone,
            style: const TextStyle(
              color: Color(0xFF535861),
              fontSize: 12.21,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: AppSize.appheight * .02,
          ),
          Text(
            email,
            style: const TextStyle(
              color: Color(0xFF535861),
              fontSize: 12.21,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: AppSize.appheight * .02,
          ),
        ],
      ),
    ),
  ));
}
