import 'package:afrahdz/controllers/ad/ad_detail.dart';
import 'package:afrahdz/controllers/edit/edit_profile_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePicker extends GetView<EditProfileController> {
  const DatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (cont) => ElevatedButton(
        onPressed: () => cont.selectDate(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(left: 10, right: AppSize.appwidth * .722),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                cont.selectedDate == null
                    ? "01/03/2002"
                    : DateFormat('dd/MM/yyyy').format(cont.selectedDate!),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BeginReservationpicker extends GetView<AdDetailController> {
  const BeginReservationpicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdDetailController>(
      builder: (cont) => ElevatedButton(
        onPressed: () => controller.selectBeginDate(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                controller.beginReservationDate == null
                    ? "Choisir une date"
                    : DateFormat('yyyy/MM/dd')
                        .format(controller.beginReservationDate!),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.border_color_outlined,
              color: Appcolors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class EndReservationpicker extends GetView<AdDetailController> {
  const EndReservationpicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdDetailController>(
      builder: (cont) => ElevatedButton(
        onPressed: () => controller.selectEndDate(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.endReservationDate == null
                    ? "Choisir une date".tr
                    : DateFormat('yyyy/MM/dd')
                        .format(controller.endReservationDate!),
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.border_color_outlined,
              color: Appcolors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
