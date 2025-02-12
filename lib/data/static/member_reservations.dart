import 'package:afrahdz/controllers/reservations/member_reservation_controller.dart';
import 'package:afrahdz/data/models/reservation.dart';
import 'package:afrahdz/views/widgets/reservations/member_reservation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

MemberReservationController memberReservationController = Get.find();

List<Tab> memberReservationsTabs = [
   Tab(text: 'Tous'.tr),
   Tab(text: 'En Attente'.tr),
   Tab(text: 'Validé'.tr),
   Tab(text: 'Annulé'.tr),
];
List<Widget> memberReservationsViews = [
  _buildReservationListView(memberReservationController.allReservations),
  _buildReservationListView(memberReservationController.reservationsEnattente),
  _buildReservationListView(memberReservationController.reservationsValide),
  _buildReservationListView(memberReservationController.reservationsAnnuler),
];

Widget _buildReservationListView(RxList<ReservationModel> reservations) {
  return Obx(() {
    if (memberReservationController.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (reservations.isEmpty) {
      return const Center(
        child: Text('No reservations found'),
      );
    } else {
      return ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final selectedReservation = reservations[index];
          return MemberReservationCard(
            selectedReservation: selectedReservation,
          );
        },
      );
    }
  });
}
