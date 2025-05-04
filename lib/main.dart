// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

import 'core/config/appwrite_config.dart';

// Repositorios
import 'data/repositories/auth_repository.dart';
import 'data/repositories/panic_button_repository.dart';
import 'data/repositories/contact_repository.dart';

// Controladores
import 'controllers/auth_controller.dart';
import 'controllers/panic_button_controller.dart';
import 'controllers/contact_controller.dart';

// Pantalla inicial
import 'presentation/pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Inicializar Appwrite
  final client    = AppwriteConfig.initClient();
  final account   = Account(client);
  final databases = Databases(client);

  // ───────────────────────────────────────────────────────────────
  // 2) Inyección de Auth
  // ───────────────────────────────────────────────────────────────
  Get.put<AuthRepository>(AuthRepository(account));
  Get.put<AuthController>(AuthController(Get.find<AuthRepository>()));

  // ───────────────────────────────────────────────────────────────
  // 3) Inyección de PanicButton
  // ───────────────────────────────────────────────────────────────
  final panicRepo = PanicButtonRepository(databases);
  Get.put<PanicButtonRepository>(panicRepo);
  Get.put<PanicButtonController>(
    PanicButtonController(repo: Get.find<PanicButtonRepository>(), account: account),
  );

  // ───────────────────────────────────────────────────────────────
  // 4) Inyección de Contacts
  // ───────────────────────────────────────────────────────────────
  final contactRepo = ContactRepository(databases);
  Get.put<ContactRepository>(contactRepo);
  Get.put<ContactController>(
    ContactController(repo: Get.find<ContactRepository>(), account: account),
  );

  // ───────────────────────────────────────────────────────────────
  // 5) Arrancar la app
  // ───────────────────────────────────────────────────────────────
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Panic Button App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const SplashPage(),
    );
  }
}
