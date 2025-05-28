import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panic_button/presentation/pages/client_registration_page.dart';
import 'package:panic_button/presentation/pages/restaurant_registration_page.dart';
import '../../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extiende el cuerpo detrás de la AppBar para el gradiente
      appBar: AppBar(
        title: const Text(
          '¡Shh! Food',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Negrita para el título del AppBar
            fontSize: 24, // Tamaño de fuente un poco más grande
          ),
        ),
        backgroundColor: Colors.transparent, // Fondo transparente para que se vea el gradiente
        elevation: 0, // Sin sombra
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white, // Ícono de logout en blanco
              size: 28, // Tamaño del ícono
            ),
            onPressed: () {
              // Confirmación antes de cerrar sesión
              Get.defaultDialog(
                title: "¿Cerrar Sesión?",
                titleStyle: const TextStyle(color: Color(0xFF4B0082)),
                middleText: "¿Estás seguro que quieres cerrar tu sesión actual?",
                middleTextStyle: const TextStyle(color: Colors.black87),
                textConfirm: "Sí",
                textCancel: "No",
                confirmTextColor: Colors.white,
                cancelTextColor: const Color(0xFF4B0082),
                buttonColor: const Color(0xFF40E0D0),
                onConfirm: () {
                  Get.back(); // Cierra el diálogo
                  _authController.logout(); // Ejecuta el logout
                },
                onCancel: () {
                  Get.back(); // Cierra el diálogo
                },
              );
            },
            tooltip: 'Cerrar Sesión', // Texto que aparece al mantener presionado
          ),
        ],
      ),
      body: Container(
        // Fondo con gradiente para un aspecto moderno y vibrante
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Un poco más dinámico
            end: Alignment.bottomRight, // Un poco más dinámico
            colors: [
              Color.fromARGB(255, 75, 0, 130), // Morado oscuro (0xFF4B0082)
              Color.fromARGB(255, 64, 224, 208), // Turquesa claro (0xFF40E0D0)
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título principal con mayor impacto
                const Text(
                  '¡Bienvenido a\nShh! Food', // Un mensaje de bienvenida más explícito
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38, // Un poco más grande
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Color.fromARGB(100, 0, 0, 0),
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  '¿Cómo deseas registrarte?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70, // Un blanco más suave
                    fontSize: 22, // Tamaño de fuente ligeramente más grande
                    fontWeight: FontWeight.w500, // Menos negrita que el título principal
                    fontStyle: FontStyle.italic, // Un poco de cursiva
                  ),
                ),
                const SizedBox(height: 50), // Más espacio antes de los botones
                // Botón de registro como Cliente
                SizedBox(
                  width: double.infinity,
                  height: 60, // Altura del botón aumentada
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add_alt_1, color: Color(0xFF4B0082)), // Ícono
                    label: const Text(
                      'Registrar como Cliente',
                      style: TextStyle(
                        fontSize: 20, // Texto más grande
                        color: Color(0xFF4B0082), // Texto morado oscuro
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40E0D0), // Fondo turquesa
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Bordes más redondeados
                      ),
                      elevation: 8, // Mayor elevación
                      shadowColor: const Color(0xFF40E0D0).withOpacity(0.5), // Sombra del color del botón
                    ),
                    onPressed: () => Get.to(() => ClientRegistrationPage()),
                  ),
                ),
                const SizedBox(height: 25), // Espacio entre botones
                // Botón de registro como Restaurante
                SizedBox(
                  width: double.infinity,
                  height: 60, // Altura del botón aumentada
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.restaurant_menu, color: Color(0xFF4B0082)), // Ícono
                    label: const Text(
                      'Registrar como Restaurante',
                      style: TextStyle(
                        fontSize: 20, // Texto más grande
                        color: Color(0xFF4B0082), // Texto morado oscuro
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40E0D0), // Fondo turquesa
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Bordes más redondeados
                      ),
                      elevation: 8, // Mayor elevación
                      shadowColor: const Color(0xFF40E0D0).withOpacity(0.5), // Sombra del color del botón
                    ),
                    onPressed: () => Get.to(() => RestaurantRegistrationPage()),
                  ),
                ),
                const SizedBox(height: 50),
                // Podrías añadir aquí un Obx para mostrar el usuario logueado si lo necesitas.
                // Obx(() => Text(
                //   'Usuario Logueado: ${_authController.currentUser.value?.email ?? 'N/A'}',
                //   style: TextStyle(color: Colors.white70, fontSize: 16),
                // )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}