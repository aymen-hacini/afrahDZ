import 'package:afrahdz/core/constants/size.dart';
import 'package:flutter/material.dart';

class CalendarTable extends StatelessWidget {
  const CalendarTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.appheight * .8,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            horizontalMargin: 12,
            dataRowMinHeight: 55,
            dataRowMaxHeight: 60,
            headingRowHeight: 50,
            columnSpacing: 30,
            headingTextStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            dataTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return const Color(0x28C628BC);
              }
              return const Color(0x28C628BC); // Use the default value.
            }),
            dividerThickness: 1,
            border: TableBorder.all(color: Colors.grey[500]!.withOpacity(.4)),
            columns: const [
              DataColumn(
                  label: Text(
                "Annonce",
                textAlign: TextAlign.center,
              )),
              DataColumn(label: Text("Client")),
              DataColumn(
                label: Text(
                  "Periode",
                ),
              ),
              DataColumn(label: Text("Date de reservation")),
            ],
            rows: const [
            
            ],
          ),
        ),
      ),
    );
  }
}
