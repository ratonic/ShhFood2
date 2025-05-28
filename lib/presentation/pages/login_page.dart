import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart'; // Asegúrate de que la ruta sea correcta

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fondo con gradiente para un aspecto moderno y vibrante
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
          // Usamos SingleChildScrollView para evitar overflow en teclados
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0), // Mayor padding para un mejor espacio
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título de la aplicación con estilo llamativo
                const Text(
                  'Inicia Sesión en\n¡Shh! Food',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34, // Tamaño de fuente más grande
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Color.fromARGB(100, 0, 0, 0), // Sombra para el texto
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50), // Más espacio
                // Campo de Correo Electrónico
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Correo electrónico',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // Campo de Contraseña
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                // Mostrar errores de autenticación
                Obx(() => _authController.error.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          _authController.error.value,
                          style: const TextStyle(
                              color: Colors.redAccent, fontWeight: FontWeight.bold), // Rojo más vivo
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox.shrink()),
                // Botón de Iniciar Sesión
                SizedBox(
                  width: double.infinity,
                  height: 55, // Altura del botón
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: _authController.isLoading.value
                          ? null // Deshabilita el botón si está cargando
                          : () => _authController.login(
                                _emailController.text.trim(),
                                _passwordController.text,
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF40E0D0), // Fondo turquesa
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Bordes más redondeados
                        ),
                        elevation: 8, // Mayor elevación
                        shadowColor: const Color(0xFF40E0D0).withOpacity(0.5), // Sombra color turquesa
                      ),
                      child: _authController.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Color(0xFF4B0082), // Color morado oscuro para el indicador
                            )
                          : const Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                fontSize: 20, // Texto más grande
                                color: Color(0xFF4B0082), // Texto morado oscuro
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Botón para ir a la página de registro
                TextButton(
                  onPressed: () => Get.toNamed('/register'), // Usar Get.toNamed si tienes rutas definidas
                  child: const Text(
                    '¿No tienes una cuenta? Regístrate',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Color blanco para el texto
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper para construir TextFields con estilo consistente
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(25, 255, 255, 255), // Blanco con 0.1 de opacidad
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0), // Negro con 0.1 de opacidad
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70), // Ícono del campo
          border: InputBorder.none, // Elimina el borde por defecto
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color(0xFF40E0D0), width: 2), // Borde turquesa cuando está enfocado
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none, // Sin borde cuando no está enfocado
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}