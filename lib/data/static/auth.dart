import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/widgets/auth/customview.dart';
import 'package:afrahdz/views/widgets/auth/signup2view.dart';
import 'package:afrahdz/views/widgets/auth/signupview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

LoginController controller = Get.find();
final width = AppSize.appwidth;
final height = AppSize.appheight;

List<Tab> tabs = const [
  Tab(
    text: 'Client',
  ),
  Tab(
    text: "Espace Member",
  ),
];

List<Widget> views = [
  CustomView(
    text: 'Nouveau Client ? ',
    userType: "client",
    emailcontroller: controller.clientloginEmailController,
    passwordcontroller: controller.clientloginPasswordController,
    ismemeberSelected: false,
  ),
  CustomView(
    text: "Nouveau membre?",
    userType: "membre",
    emailcontroller: controller.memberloginEmailController,
    passwordcontroller: controller.memberpasswordController,
    ismemeberSelected: true,
  )
];
List<Widget> signupViews = [
  const Signupview(
    text: "Deja client ? ",
    ismember: false,
  ),
  const Signupview(
    text: "Deja membre ? ",
    ismember: true,
  ),
];

List<Widget> signup2Views = [
  const Signup2view(
    text: "Deja client ? ",
    isMember: false,
  ),
  const Signup2view(
    text: "Deja membre ? ",
    isMember: true,
  ),
];
