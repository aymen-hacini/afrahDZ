import 'dart:convert';

import 'package:afrahdz/core/constants/api.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/core/services/ad_service.dart';
import 'package:afrahdz/core/services/homepage_service.dart';
import 'package:afrahdz/core/services/reservation_service.dart';
import 'package:afrahdz/data/models/annonce.dart';
import 'package:afrahdz/data/models/full_ad_details.dart';
import 'package:afrahdz/views/widgets/addetail/type_fete_popup_reservation.dart';
import 'package:afrahdz/views/widgets/edit/date_picker.dart';
import 'package:afrahdz/views/widgets/homepage/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AdDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AdService adService = AdService(); // Instance of AdService
  final ReservationService reservationService =
      ReservationService(); // instance of reservation service
  final HomepageService homepageService =
      HomepageService(); // instance of reservation service
  late PageController pageController;
  VideoPlayerController? videoController; // Make it nullable
  final GetStorage storage = GetStorage();

  DateTime? beginReservationDate;
  DateTime? endReservationDate;
  String? selectedFete;

  bool get isLoggedIn => storage.read('token') != null;
  String? get userType => storage.read('userType');

  var currentPage = 0.obs;

  var isLoading = true.obs; // Observable loading state
  var memberAds = <AdModel>[].obs; // Observable list of member ads

  var selectedAdDetails = FullAdDetails(
          id: 0,
          name: '',
          category: '',
          eventType: '',
          city: '',
          address: '',
          creationDate: '',
          mobile: '',
          price: 0,
          visits: 0,
          likes: 0,
          idmobmre: 0,
          imageFullPath: '',
          videoFullPath: '',
          boost: {"": ""},
          images: [],
          actions: [],
          allowed: false,
          liked: false)
      .obs; // Observable selected ad details

  // Textediting controllers

  late TextEditingController namecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController phonecontroller;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    namecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    phonecontroller = TextEditingController();
  }

  void onPageChanged(int page) {
    currentPage.value = page;
    // Play the video if the user scrolls to the video page
    if (selectedAdDetails.value.videoFullPath.isNotEmpty &&
        page == selectedAdDetails.value.images.length + 1) {
      videoController?.play();
      videoController?.setLooping(true); // Loop the video
    } else if (selectedAdDetails.value.videoFullPath.isNotEmpty) {
      videoController?.pause(); // Pause the video when scrolling away
    }

  }

  @override
  void onClose() {
    pageController.dispose();
    if (selectedAdDetails.value.videoFullPath.isNotEmpty) {
      videoController?.dispose();
    }

    super.onClose();
  }

  // Function to fetch full ad details by ID
  Future<void> fetchFullAdDetails(int adId) async {
    print(userType);
    try {
      isLoading(true); // Set loading to true
      final adDetails = await adService
          .getFullAdDetails(adId); // Call AdService to fetch ad details
      selectedAdDetails.value = adDetails;
      if (selectedAdDetails.value.videoFullPath.isNotEmpty) {
        final videoUrl =
            '${ApiLinkNames.serverimage}${selectedAdDetails.value.videoFullPath}';

        videoController = VideoPlayerController.networkUrl(
          Uri.parse(videoUrl),
        )..initialize().then((_) {
            update(); // Notify listeners after video is initialized
          }).catchError((error) {});
      }
    } catch (e) {
      Get.snackbar(
          'Erreur', "Impossible de récupérer les détails de l'annonce");
    } finally {
      isLoading(false); // Set loading to false
    }

    print(selectedAdDetails.value.id);
  }

  // Function to fetch vip ads
  Future<void> fetchMemberAds(int memberId) async {
    try {
      isLoading(true); // Set loading to true
      final fetchedAds =
          await adService.getMemberAds(memberId); // Call AdService to fetch ads
      memberAds.value = fetchedAds; // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Impossible de récupérer les annonces Member');
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Like an ad and add it to favorites
  Future<void> likeAd(int adId) async {
    await adService.likeAd(adId);
  }

  // Future<void> selectBeginDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate:
  //         beginReservationDate ?? DateTime.now().add(const Duration(days: 1)),
  //     firstDate: DateTime.now().add(const Duration(days: 1)),
  //     lastDate: DateTime(2101),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: Appcolors.primaryColor, // Header background color
  //             onPrimary: Colors.white, // Header text color
  //             surface: Colors.white, // Calendar background color
  //             onSurface: Colors.black, // Calendar text color
  //           ),
  //           dialogBackgroundColor: Colors.white,
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   if (picked != null && picked != beginReservationDate) {
  //     beginReservationDate = picked;
  //     update();
  //   }
  // }

  Future<List<DateTime>> fetchReservedDates(String memberID) async {
    final response = await http.get(
      Uri.parse(
          'https://www.afrahdz.com/api/resarvation?idMember[eq]=$memberID'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        final List<dynamic> reservations = data['data'];
        print(reservations);
        // Extract reservationDate from each reservation
        return reservations
            .map(
                (reservation) => DateTime.parse(reservation['reservationDate']))
            .toList();
      }
    }
    return []; // Return an empty list if no reservations or API call fails
  }

  Future<void> selectBeginDate(BuildContext context) async {
    final String memberID = selectedAdDetails.value.idmobmre
        .toString(); // Replace with actual member ID
    final List<DateTime> reservedDates = await fetchReservedDates(memberID);

    print(reservedDates);
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Appcolors.primaryColor, // Header background color
                  onPrimary: Colors.white, // Header text color
                  surface: Colors.white, // Calendar background color
                  onSurface: Colors.black, // Calendar text color
                ),
                dialogBackgroundColor:
                    Colors.white, // Background color of the dialog
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor:
                        Colors.blue, // Buttons text color (e.g., Cancel, OK)
                  ),
                ),
              ),
              child: CalendarDatePicker(
                initialDate: beginReservationDate ??
                    DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now().add(const Duration(days: 1)),
                lastDate: DateTime(2101),
                onDateChanged: (DateTime date) {
                  Navigator.of(context).pop(date);
                },
                selectableDayPredicate: (DateTime date) {
                  // Disable reserved dates from being selected
                  return !reservedDates.any((reservedDate) =>
                      reservedDate.year == date.year &&
                      reservedDate.month == date.month &&
                      reservedDate.day == date.day);
                },
              ),
            ),
          ),
        );
      },
    );

    if (picked != null && picked != beginReservationDate) {
      beginReservationDate = picked;
      update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endReservationDate ??
          beginReservationDate ??
          DateTime.now(), // Ensure initialDate is not before firstDate,
      firstDate: beginReservationDate!,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Appcolors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Calendar background color
              onSurface: Colors.black, // Calendar text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != endReservationDate) {
      endReservationDate = picked;
      update();
    }
  }

  // Function to create a reservation
  Future<void> createReservation() async {
    final userId = homepageService.getUserIdFromToken();
    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the date to 'Y-m-d'
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      isLoading(true); // Set loading to true
      await reservationService.createReservation(
          reservationDate:
              DateFormat('yyyy-MM-dd').format(beginReservationDate!),
          finalReservationDate:
              DateFormat('yyyy-MM-dd').format(endReservationDate!),
          name: namecontroller.text,
          email: emailcontroller.text,
          phone: phonecontroller.text,
          type: selectedFete!,
          date: formattedDate,
          idMember: selectedAdDetails.value.idmobmre.toString(),
          idAnnonce: selectedAdDetails.value.id.toString(),
          idClient: userId.toString());
      Get.snackbar('Success'.tr, 'reserveSucces'.tr);
      namecontroller.clear();
      emailcontroller.clear();
      phonecontroller.clear();
    } catch (e) {
      Get.snackbar('Erreur'.tr, 'reserveErreur'.tr);
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  void makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch $uri";
    }
  }

  void showReserveForm() {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      persistent: true,
      SizedBox(
        height: AppSize.appheight * .9,
        child: Padding(
          padding: EdgeInsets.only(
              top: AppSize.appheight * .03,
              bottom: AppSize.appheight * .01,
              left: AppSize.appwidth * .04,
              right: AppSize.appwidth * .04),
          child: Stack(
            children: [
              ListView(
                children: [
                  Center(
                    child: Text(
                      "ReserveTitle".tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Text(
                    "reserveDate".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .01,
                  ),
                  const BeginReservationpicker(),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Text(
                    "Enddate".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .01,
                  ),
                  const EndReservationpicker(),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Text(
                    'EditprofileName'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .01,
                  ),
                  ReservationTextfield(
                    hint: "EditprofileName".tr,
                    controller: namecontroller,
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Text(
                    'EditprofileEmail'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .01,
                  ),
                  ReservationTextfield(
                    keyboardtype: TextInputType.emailAddress,
                    hint: "exemple@gmail.com",
                    controller: emailcontroller,
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Text(
                    'EditprofilePhone'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .01,
                  ),
                  ReservationTextfield(
                    keyboardtype: TextInputType.number,
                    hint: "0555005500",
                    controller: phonecontroller,
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  Text(
                    'AdFete'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .01,
                  ),
                  const TypeFetePopupReservation(),
                  SizedBox(
                    height: AppSize.appheight * .1,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(
                  () => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: AppSize.appheight * .01),
                    child: AnimatedContainer(
                      duration: 300.milliseconds,
                      width: isLoading.value
                          ? AppSize.appwidth * .2
                          : AppSize.appwidth * .9,
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsets.zero, // Remove default padding
                              shadowColor:
                                  Colors.black, // Remove default shadow
                              elevation: 4),
                          onPressed: () => createReservation(),
                          child: Ink(
                            height: AppSize.appheight * .06,
                            decoration: BoxDecoration(
                                gradient: Appcolors.primaryGradient,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: isLoading.value
                                  ? const CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.white,
                                    )
                                  : Text(
                                      'Reservebtn'.tr,
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
