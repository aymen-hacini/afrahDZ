import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
          primaryColor: Colors.white,
          canvasColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          colorScheme: const ColorScheme.light(primary: Colors.white),
          primaryColorLight: Colors.white,
          primaryColorDark: Colors.white,
        ),
        title: 'Afrah DZ',
        getPages: pages,
        initialBinding: InitialBinding(),
      ),
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily initialize AuthController
    Get.put(LoginController());
  }
}
