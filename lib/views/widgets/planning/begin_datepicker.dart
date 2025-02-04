import 'package:afrahdz/controllers/planning/planning_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BeginDatepicker extends GetView<PlanningController> {
  const BeginDatepicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanningController>(
      builder: (cont) => ElevatedButton(
        onPressed: () {
          cont.selectBeginDate(context);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
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
                cont.beginselectedDate == null
                    ? "Choisir date"
                    : DateFormat('yyyy-MM-dd').format(cont.beginselectedDate!),
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
