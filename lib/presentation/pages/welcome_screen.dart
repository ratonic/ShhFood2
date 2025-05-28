import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart'; // Asegúrate de que las rutas sean correctas
import 'register_page.dart'; // Asegúrate de que las rutas sean correctas

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Un poco más dinámico para el inicio
            end: Alignment.bottomRight, // Un poco más dinámico para el final
            colors: [
              Color.fromARGB(255, 75, 0, 130), // Morado oscuro (0xFF4B0082)
              Color.fromARGB(255, 64, 224, 208), // Turquesa claro (0xFF40E0D0)
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40), // Más padding horizontal
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono grande del logo de Shh! Food
                // Puedes reemplazar esto con tu logo si lo tienes como un asset
                const Icon(
                  Icons.fastfood, // Un ícono representativo de comida
                  size: 120, // Tamaño grande del ícono
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(100, 0, 0, 0), // Sombra más pronunciada
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Espacio entre el ícono y el texto
                const Text(
                  '¡Bienvenido a',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white70, // Un blanco más suave para el "Bienvenido a"
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text(
                  'Shh! Food',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 48, // Tamaño de fuente más grande para el nombre
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Color.fromARGB(100, 0, 0, 0), // Sombra para el texto principal
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Más espacio antes de los botones
                SizedBox(
                  width: double.infinity, // El botón ocupa todo el ancho disponible
                  height: 55, // Altura del botón
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => LoginPage()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40E0D0), // Fondo turquesa
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Bordes más redondeados
                      ),
                      elevation: 8, // Una elevación más notoria
                      shadowColor: const Color(0xFF40E0D0).withOpacity(0.5), // Sombra color turquesa
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 20, // Texto más grande
                        color: Color(0xFF4B0082), // Texto morado oscuro
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25), // Espacio entre botones
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => RegisterPage()),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2), // Borde blanco y más grueso
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Bordes más redondeados
                      ),
                      elevation: 5, // Una ligera elevación
                      shadowColor: Colors.white.withOpacity(0.3), // Sombra color blanco
                    ),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 20, // Texto más grande
                        color: Colors.white, // Texto blanco
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}