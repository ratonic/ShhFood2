import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator
import 'package:geocoding/geocoding.dart'; // Import geocoding
import '../../../controllers/auth_controller.dart';

class ClientRegistrationPage extends StatefulWidget {
  ClientRegistrationPage({Key? key}) : super(key: key);

  @override
  State<ClientRegistrationPage> createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  bool _isLocating = false; // To show loading state for location

  // Function to get current location and populate address field
  Future<void> _getCurrentLocationAndAddress() async {
    setState(() {
      _isLocating = true;
    });

    try {
      // Check and request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Permiso denegado', 'No se puede obtener la ubicación sin permiso.');
          setState(() {
            _isLocating = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Permiso denegado permanentemente',
          'La ubicación ha sido denegada permanentemente. Por favor, habilítala desde la configuración de la aplicación.',
          duration: const Duration(seconds: 5),
        );
        setState(() {
          _isLocating = false;
        });
        return;
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Servicio de ubicación desactivado', 'Por favor, activa los servicios de ubicación en tu dispositivo.');
        setState(() {
          _isLocating = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        // You can add a timeout if needed, e.g., timeLimit: const Duration(seconds: 10)
      );

      // Reverse geocode the coordinates to get the address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // Construct the address from available information
        String address = [
          place.thoroughfare, // Street name
          place.subThoroughfare, // Street number
          place.locality, // City
          place.administrativeArea, // State/Province
          place.country, // Country
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        _addressController.text = address;
        Get.snackbar('Ubicación obtenida', 'Dirección pre-llenada con tu ubicación actual.');
      } else {
        Get.snackbar('Error de geocodificación', 'No se pudo obtener una dirección para tu ubicación actual.');
      }
    } catch (e) {
      print('Error getting location: $e');
      Get.snackbar('Error', 'No se pudo obtener la ubicación. Inténtalo de nuevo.');
    } finally {
      setState(() {
        _isLocating = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(230, 75, 0, 130), // Color(0xFF4B0082) con opacidad ~0.9
              Color.fromARGB(128, 64, 224, 208), // Color(0xFF40E0D0) con opacidad ~0.5
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
                  '¡Únete a Nosotros!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Color.fromARGB(76, 0, 0, 0),
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: _nameController,
                  labelText: 'Nombre Completo',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
                // Address TextField with location button
                _buildAddressTextField(
                  controller: _addressController,
                  labelText: 'Dirección',
                  icon: Icons.home_outlined,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _phoneController,
                  labelText: 'Teléfono',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40E0D0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 5,
                    ),
                    onPressed: () {
                      _authController.registerClient(
                        name: _nameController.text,
                        address: _addressController.text,
                        phone: _phoneController.text,
                      );
                    },
                    child: const Text(
                      'Registrar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B0082),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.back(); // Or navigate to your login page
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
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(25, 255, 255, 255), // Colors.white.withOpacity(0.1)
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0), // Colors.black.withOpacity(0.1)
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF40E0D0), width: 2),
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

  Widget _buildAddressTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(25, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          suffixIcon: _isLocating
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF40E0D0)),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.my_location, color: Colors.white70),
                  onPressed: _getCurrentLocationAndAddress,
                ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF40E0D0), width: 2),
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