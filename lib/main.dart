import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

import 'core/config/appwrite_config.dart';
import 'data/repositories/auth_repository.dart';
import 'controllers/auth_controller.dart';

import 'data/repositories/panic_button_repository.dart';
import 'controllers/panic_button_controller.dart';

import 'presentation/pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Inicializar Appwrite
  final client   = AppwriteConfig.initClient();
  final account  = Account(client);
  final databases = Databases(client);

  // 2) Inyección de Auth
  Get.put(AuthRepository(account));
  Get.put(AuthController(Get.find<AuthRepository>()));

  // 3) Inyección de PanicButtonRepository y PanicButtonController
  final panicRepo = PanicButtonRepository(databases);
  Get.put(panicRepo);
  Get.put(PanicButtonController(repo: panicRepo, account: account));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panic Button App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const SplashPage(),
    );
  }
}
