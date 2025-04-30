// lib/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panic Button Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().logout(),
          ),
        ],
      ),
      body: const Center(
        child: Text('¡Bienvenido! Aquí irá tu Home de Botones de Pánico.'),
      ),
    );
  }
}
