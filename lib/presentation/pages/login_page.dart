// lib/presentation/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            TextFormField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (authCtrl.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authCtrl.login(_emailCtrl.text, _passCtrl.text);
                  }
                },
                child: const Text('Iniciar Sesión'),
              );
            }),
            TextButton(
              onPressed: () => Get.to(() => RegisterPage()),
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
            Obx(() {
              if (authCtrl.error.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(authCtrl.error.value,
                      style: const TextStyle(color: Colors.red)),
                );
              }
              return const SizedBox.shrink();
            }),
          ]),
        ),
      ),
    );
  }
}
