import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../data/repositories/auth_repository.dart';

class ClientHomePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  ClientHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Permite que el gradiente se vea a través del AppBar
      appBar: AppBar(
        title: const Text(
          '¡Shh! Food', // Mantén el nombre de la app para branding
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26, // Ligeramente más grande para que destaque
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Color.fromARGB(100, 0, 0, 0), // Sombra para el texto del título
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true, // Centra el título
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0, // Sin sombra para un look moderno
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 30), // Ícono de menú blanco
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  Get.snackbar(
                    'Próximamente',
                    'Navegar a perfil del cliente',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
                    colorText: const Color(0xFF4B0082),
                  );
                  break;
                case 'orders':
                  Get.snackbar(
                    'Próximamente',
                    'Navegar a historial de órdenes',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
                    colorText: const Color(0xFF4B0082),
                  );
                  break;
                case 'logout':
                  _showLogoutConfirmationDialog(); // Muestra el diálogo de confirmación
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Mi Perfil', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'orders',
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Mis Órdenes', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.redAccent), // Rojo para indicar acción de salida
                    SizedBox(width: 8),
                    Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            color: Colors.white.withOpacity(0.95), // Fondo blanco semi-transparente para el menú
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 8,
          ),
        ],
      ),
      body: Container(
        // Fondo con gradiente de pantalla completa
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
        child: Column(
          children: [
            // Espacio para el AppBar y un poco más
            const SizedBox(height: 120), // Ajustado para dar espacio al AppBar y al título
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                'Descubre los mejores restaurantes cerca de ti:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24, // Texto más grande y prominente
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(blurRadius: 5, color: Colors.black38, offset: Offset(2, 2)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _authRepository.getRestaurants(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white)); // Indicador blanco
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error al cargar restaurantes: ${snapshot.error}\nPor favor, intenta de nuevo.',
                        style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final restaurants = snapshot.data ?? [];

                  if (restaurants.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.restaurant_menu, size: 60, color: Colors.white54),
                          const SizedBox(height: 10),
                          const Text(
                            '¡Ups! Parece que no hay restaurantes disponibles aún.',
                            style: TextStyle(color: Colors.white70, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Esto solo forzará la recarga si el FutureBuilder lo permite
                              // Para una recarga dinámica, considera usar GetxController.refresh() o GetBuilder
                              Get.snackbar(
                                'Actualizado',
                                'Intentando cargar restaurantes de nuevo.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
                                colorText: const Color(0xFF4B0082),
                              );
                            },
                            icon: const Icon(Icons.refresh, color: Color(0xFF4B0082)),
                            label: const Text(
                              'Reintentar',
                              style: TextStyle(color: Color(0xFF4B0082), fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF40E0D0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75, // Ajusta para que el contenido se vea bien
                    ),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return _buildRestaurantCard(restaurant);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir una tarjeta de restaurante consistente
  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Card(
      elevation: 10, // Elevación aumentada para un efecto flotante
      color: Colors.white, // Fondo blanco limpio para la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Esquinas más redondeadas
      ),
      clipBehavior: Clip.antiAlias, // Asegura que la imagen respete el radio del borde
      child: InkWell(
        // Proporciona retroalimentación visual al tocar
        onTap: () {
          // TODO: Implementar navegación a la página de detalles del restaurante
          Get.snackbar(
            '¡Restaurante Seleccionado!',
            'Has seleccionado: ${restaurant['name']}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
            colorText: const Color(0xFF4B0082),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estira la imagen
          children: [
            Expanded(
              flex: 3, // La imagen ocupa más espacio
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20), // Coincide con el radio del borde de la tarjeta
                ),
                child: Image.network(
                  restaurant['imageUrl'] ?? 'https://via.placeholder.com/200/4B0082/FFFFFF?text=Shh!Food', // Placeholder personalizado
                  height: double.infinity, // Rellena la altura disponible
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        color: const Color(0xFF40E0D0), // Indicador de carga color turquesa
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                          Text('No Image', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2, // El contenido de texto ocupa menos espacio
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye los elementos
                  children: [
                    Text(
                      restaurant['name'] ?? 'Nombre Desconocido',
                      style: const TextStyle(
                        fontSize: 18, // Fuente ligeramente más grande para el nombre
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B0082), // Usa morado para el texto
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      restaurant['description'] ?? 'Descripción no disponible.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]), // Descripción ligeramente más grande
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(), // Empuja la siguiente fila hacia abajo
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            restaurant['serviceHours'] ?? 'Horario no especificado',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo de confirmación para cerrar sesión
  void _showLogoutConfirmationDialog() {
    Get.defaultDialog(
      title: "Confirmar Cierre de Sesión",
      titleStyle: const TextStyle(color: Color(0xFF4B0082), fontWeight: FontWeight.bold),
      middleText: "¿Estás seguro que deseas cerrar tu sesión?",
      middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      backgroundColor: Colors.white,
      radius: 15,
      buttonColor: const Color(0xFF40E0D0),
      textConfirm: "Sí, cerrar sesión",
      textCancel: "Cancelar",
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF4B0082),
      onConfirm: () {
        Get.back(); // Cierra el diálogo
        _authController.logout(); // Realiza el logout
      },
      onCancel: () {
        Get.back(); // Cierra el diálogo
      },
    );
  }
}