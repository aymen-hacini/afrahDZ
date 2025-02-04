import 'package:afrahdz/core/constants/routes_names.dart';
import 'package:afrahdz/core/functions/changefont.dart';
import 'package:afrahdz/no_internet.dart';
import 'package:afrahdz/views/screens/annonce/add_annonce.dart';
import 'package:afrahdz/views/screens/annonce/boost_annonce.dart';
import 'package:afrahdz/views/screens/annonce/my_announces.dart';
import 'package:afrahdz/views/screens/auth/login/login.dart';
import 'package:afrahdz/views/screens/auth/signup/signup.dart';
import 'package:afrahdz/views/screens/auth/signup/signup2.dart';
import 'package:afrahdz/views/screens/edit/edit_profile.dart';
import 'package:afrahdz/views/screens/favorites/favorites.dart';
import 'package:afrahdz/views/screens/homepage/homepage.dart';
import 'package:afrahdz/views/screens/homepage/homepage_allproducts.dart';
import 'package:afrahdz/views/screens/planning/calendrier.dart';
import 'package:afrahdz/views/screens/reservations/client_reservations.dart';
import 'package:afrahdz/views/screens/reservations/member_reservations.dart';
import 'package:afrahdz/views/screens/splashscreen/splashscreen.dart';
import 'package:afrahdz/views/screens/support/about.dart';
import 'package:afrahdz/views/screens/support/contact.dart';
import 'package:get/get.dart';

List<GetPage> pages = [
  GetPage(
      name: "/",
      page: () => const SplashScreen(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.login,
      page: () => const Login(),
      middlewares: [FontMiddleware()],
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.signup,
      page: () => const Signup(),
      transition: Transition.fadeIn,
      middlewares: [FontMiddleware()]),
  GetPage(
      name: AppRoutesNames.signup2,
      page: () => const Signup2(),
      transition: Transition.fadeIn,
      middlewares: [FontMiddleware()]),
  GetPage(
      name: AppRoutesNames.homepage,
      page: () => const Homepage(),
      transition: Transition.fade),
  GetPage(
      name: AppRoutesNames.allproducts,
      page: () => const HomepageAllproducts(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.editProfile,
      page: () => const EditProfile(),
      transition: Transition.zoom),
  GetPage(
      name: AppRoutesNames.addannonce,
      page: () => const AddAnnonce(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutesNames.clientReservations,
      transition: Transition.leftToRightWithFade,
      page: () => const ClientReservations()),
  GetPage(
      name: AppRoutesNames.boosterAnnonce,
      page: () => const BoostAnnonce(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutesNames.mesannonces,
      page: () => const MyAnnounces(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutesNames.about,
      page: () => const About(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutesNames.contact,
      page: () => const Contact(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutesNames.memberReservations,
      page: () => const MemberReservations(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutesNames.planning,
      page: () => const Planning(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutesNames.favorites,
      page: () => const Favorites(),
      transition: Transition.leftToRightWithFade),
  GetPage(
    name: '/no-internet',
    page: () => const NoInternetScreen(),
  ),
];
