import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'welcome_screen.dart'; // Asegúrate de que la ruta sea correcta

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navega a la WelcomeScreen después de 3 segundos.
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Utiliza un gradiente para un fondo más dinámico
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 75, 0, 130), // Morado oscuro (0xFF4B0082)
              Color.fromARGB(255, 64, 224, 208), // Turquesa claro (0xFF40E0D0)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono de la aplicación (puedes reemplazarlo con tu logo)
              const Icon(
                Icons.restaurant, // Un ícono representativo de comida
                size: 100, // Tamaño del ícono
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Color.fromARGB(100, 0, 0, 0), // Sombra sutil
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Espacio entre el ícono y el texto
              // Texto del nombre de la aplicación con estilo mejorado
              const Text(
                '¡Shh! Food',
                style: TextStyle(
                  fontSize: 45, // Tamaño de fuente ligeramente más grande
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3, // Espaciado entre letras para un efecto "impactante"
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(100, 0, 0, 0), // Sombra para el texto
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50), // Más espacio antes del indicador de progreso
              // Indicador de progreso con un tamaño ligeramente mayor y sombra
              SizedBox(
                width: 60, // Ancho deseado para el CircularProgressIndicator
                height: 60, // Alto deseado para el CircularProgressIndicator
                child: CircularProgressIndicator(
                  color: Colors.white, // Indicador blanco para contraste
                  backgroundColor: const Color(0xFF40E0D0).withOpacity(0.5), // Fondo turquesa suave
                  strokeWidth: 6, // Grosor del círculo
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4B0082)), // Color del progreso (morado oscuro)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}