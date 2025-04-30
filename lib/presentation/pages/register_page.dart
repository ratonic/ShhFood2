// lib/presentation/pages/register_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) => v!.isEmpty || !GetUtils.isEmail(v)
                  ? 'Email inválido' : null,
            ),
            TextFormField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (v) => v!.length < 6 ? 'Mínimo 6 caracteres' : null,
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (authCtrl.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authCtrl.register(
                      _emailCtrl.text,
                      _passCtrl.text,
                      _nameCtrl.text,
                    );
                  }
                },
                child: const Text('Registrarse'),
              );
            }),
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
