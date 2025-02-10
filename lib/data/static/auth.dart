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

List<Tab> tabs =  [
  Tab(
    text: "AuthRoleClient".tr,
  ),
  Tab(
    text: "AuthRoleMember".tr,
  ),
];

List<Widget> views = [
  CustomView(
    text: "ClientHookQst".tr,
    userType: "client",
    emailcontroller: controller.clientloginEmailController,
    passwordcontroller: controller.clientloginPasswordController,
    ismemeberSelected: false,
  ),
  CustomView(
    text: "MembreHookQst".tr,
    userType: "membre",
    emailcontroller: controller.memberloginEmailController,
    passwordcontroller: controller.memberpasswordController,
    ismemeberSelected: true,
  )
];
List<Widget> signupViews = [
   Signupview(
    text: "SignupClientHeader".tr,
    ismember: false,
  ),
   Signupview(
    text: "SignupMemberHeader".tr,
    ismember: true,
  ),
];

List<Widget> signup2Views = [
   Signup2view(
    text: "SignupClientHeader".tr,
    isMember: false,
  ),
   Signup2view(
    text: "SignupMemberHeader".tr,
    isMember: true,
  ),
];
