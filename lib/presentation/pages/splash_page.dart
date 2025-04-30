// lib/presentation/pages/splash_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    _checkAuth(authController);
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  void _checkAuth(AuthController authController) async {
    await Future.delayed(const Duration(seconds: 1));
    final loggedIn = await authController.checkAuth();
    if (loggedIn) {
      Get.off(() => HomePage());
    } else {
      Get.off(() => LoginPage());
    }
  }
}
