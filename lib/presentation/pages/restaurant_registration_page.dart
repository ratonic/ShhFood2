import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart'; // Asegúrate de que la ruta sea correcta

class RestaurantRegistrationPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _serviceHoursController = TextEditingController();
  final _imageUrlController = TextEditingController(); // Para la URL de la imagen del restaurante

  final AuthController _authController = Get.find<AuthController>();

  RestaurantRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(230, 75, 0, 130), // Morado oscuro (0xFF4B0082) con opacidad ~0.9
              Color.fromARGB(128, 64, 224, 208), // Turquesa claro (0xFF40E0D0) con opacidad ~0.5
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Registra Tu Restaurante',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Color.fromARGB(76, 0, 0, 0), // Sombra negra con 0.3 de opacidad
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: _nameController,
                  labelText: 'Nombre del Restaurante',
                  icon: Icons.restaurant_menu,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _addressController,
                  labelText: 'Dirección',
                  icon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _phoneController,
                  labelText: 'Teléfono',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _descriptionController,
                  labelText: 'Descripción del Restaurante',
                  icon: Icons.info_outline,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _serviceHoursController,
                  labelText: 'Horario de Servicio (Ej. L-S: 10AM-10PM)',
                  icon: Icons.access_time_outlined,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _imageUrlController,
                  labelText: 'URL de la Imagen (Logo/Fachada)',
                  icon: Icons.image_outlined,
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40E0D0), // Turquesa
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 5,
                    ),
                    onPressed: () {
                      _authController.registerRestaurant(
                        name: _nameController.text.trim(),
                        address: _addressController.text.trim(),
                        phone: _phoneController.text.trim(),
                        description: _descriptionController.text.trim(),
                        serviceHours: _serviceHoursController.text.trim(),
                        imageUrl: _imageUrlController.text.trim(),
                      );
                    },
                    child: const Text(
                      'Registrar Restaurante',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B0082), // Morado oscuro
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.back(); // O la ruta a tu página de login
                  },
                  child: const Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1, // Permite múltiples líneas para la descripción
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(25, 255, 255, 255), // Blanco con 0.1 de opacidad
        borderRadius: BorderRadius.circular(12),
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
        maxLines: maxLines, // Aplica el número máximo de líneas
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF40E0D0), width: 2), // Turquesa
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}