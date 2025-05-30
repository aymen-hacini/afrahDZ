import 'package:afrahdz/controllers/reservations/client_reservation_controller.dart';
import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/images.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/data/models/reservation.dart';
import 'package:afrahdz/views/widgets/auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReservationCard extends GetView<ClientReservationController> {
  final ReservationModel selectedReservation;
  final String isValidated;
  const ReservationCard(
      {super.key,
      required this.selectedReservation,
      required this.isValidated});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appheight * .22,
      width: AppSize.appwidth,
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.appwidth * .04,
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSize.appwidth * .025),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurStyle: BlurStyle.normal,
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 1)
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/svg/check.svg"),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  const Text(
                    'reserver au',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    selectedReservation.reservationDate,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Text(
                isValidated == "attente" ? "En attente" : 'Valider',
                style: const TextStyle(
                  color: Color(0x7F408C59),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => _showDeletepopup(context,
                    () => controller.deleteReservation(selectedReservation)),
                icon: SvgPicture.asset("assets/svg/delete.svg"),
              )
            ],
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
                    "${ApiLinkNames.serverimage}${selectedReservation.adDetails!.imageFullPath}",
                    fit: BoxFit.fill,
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
                    selectedReservation.adDetails!.name,
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
                        "${selectedReservation.adDetails!.address} / ${selectedReservation.adDetails!.city}",
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
                    child: Row(
                      children: [
                        GradientText(
                          text:
                              "${selectedReservation.adDetails!.price.toStringAsFixed(2)} DA",
                          gradient: Appcolors.primaryGradient,
                          style: const TextStyle(
                            fontSize: 16.28,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

void _showDeletepopup(BuildContext context, VoidCallback deleteAction) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: AppSize.appheight * .28),
        child: AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/svg/deleteAlert.svg"),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Get.back, icon: const Icon(Icons.close))
                ],
              ),
              SizedBox(
                height: AppSize.appheight * .03,
              ),
              const Text(
                'Annuler la reservation',
                style: TextStyle(
                  color: Color(0xFF181D27),
                  fontSize: 15.70,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.56,
                ),
              ),
              SizedBox(
                height: AppSize.appheight * .01,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Êtes-vous sûr de vouloir ',
                      style: TextStyle(
                        color: Color(0xFF535861),
                        fontSize: 12.21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                    TextSpan(
                      text: 'Annuler votre reservation',
                      style: TextStyle(
                        color: Color(0xFF535861),
                        fontSize: 12.21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.43,
                      ),
                    ),
                    TextSpan(
                      text: '? Cette action ne peut être annulée.',
                      style: TextStyle(
                        color: Color(0xFF535861),
                        fontSize: 12.21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.appwidth * .07,
                      vertical: AppSize.appheight * .01),
                  foregroundColor: Colors.black),
              onPressed: () {
                Get.back();
              },
              child: const Text('Annulée'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD92D20),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.appwidth * .1,
                      vertical: AppSize.appheight * .01),
                  foregroundColor: Colors.white),
              onPressed: () {
                deleteAction();
                Get.back();
              },
              child: const Text('OUI'),
            ),
          ],
        ),
      );
    },
  );
}
