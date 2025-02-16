import 'package:afrahdz/controllers/auth/login_controller.dart';
import 'package:afrahdz/core/localization/translations.dart';
import 'package:afrahdz/firebase_options.dart';
import 'package:afrahdz/routes.dart';
import 'package:afrahdz/setup_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFirebaseMessaging();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await GetStorage.init();
  final box = GetStorage();
  String? langCode = box.read('locale'); // Read saved locale
  Locale locale =
      langCode != null ? Locale(langCode) : const Locale('fr', 'FR');
  runApp(MyApp(
    locale: locale,
  ));
}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({super.key, required this.locale});

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
        translations: MyTranslations(),
        locale: locale,
        fallbackLocale: Get.deviceLocale,
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
