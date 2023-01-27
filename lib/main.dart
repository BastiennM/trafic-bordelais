import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import 'bindings/initial_bindings.dart';
import 'core/constants/config.dart';
import 'core/constants/themes.dart';
import 'localization/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'router/app_pages.dart';

Future<void> mainCommon(Config config) async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ThemeModeController controller = Get.put(ThemeModeController());
  controller.setTheme();

  runZonedGuarded<Future<void>>(() async {
    runApp(MyApp(
      config: config,
    ));
  }, (Object error, StackTrace stackTrace) async {
    if (kDebugMode) {
      print(error);
    }
  });
}

class MyApp extends StatelessWidget {
  final Config config;
  const MyApp({super.key, required this.config});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (BuildContext context) => config,
        child: GetMaterialApp(
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          initialBinding: InitialBindings(),
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: ThemeMode.system,
          locale: const Locale('fr', 'FR'),
          translations: AppLocalization(),
          navigatorKey: Get.key, // set property
        ));
  }
}
