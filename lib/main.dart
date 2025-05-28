import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

import 'core/constants/appwrite_constants.dart';
import 'core/config/app_config.dart';
import 'core/routes/app_routes.dart';
import 'data/repositories/auth_repository.dart';
import 'controllers/auth_controller.dart';
import 'presentation/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Appwrite
  final client = Client()
    ..setEndpoint(AppwriteConstants.endpoint)
    ..setProject(AppwriteConstants.projectId)
    ..setSelfSigned(status: true);

  final account = Account(client);
  final databases = Databases(client);

  // Initialize GetX controllers
  Get.put<AuthRepository>(AuthRepository(
    account,
    databases,
    AppwriteConstants.databaseId
  ));
  Get.put<AuthController>(AuthController(Get.find<AuthRepository>()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: AppConfig.theme,
      getPages: AppRoutes.routes,
      home: const SplashScreen(),
    );
  }
}
