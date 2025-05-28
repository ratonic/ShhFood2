import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panic_button/models/menu_item.dart'; // Ensure this path is correct
import '../../controllers/auth_controller.dart';

class RestaurantHomePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final RxList<MenuItem> menuItems = <MenuItem>[].obs; // Using RxList for reactivity

  RestaurantHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows the gradient to show through the AppBar
      appBar: AppBar(
        title: const Text(
          '¡Shh! Food - Restaurante', // Clearer title for restaurant panel
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22, // Slightly larger for prominence
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Color.fromARGB(100, 0, 0, 0),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow for a modern look
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 30), // White menu icon
            onSelected: (value) {
              switch (value) {
                case 'menu':
                  Get.snackbar(
                    'Navegación',
                    'Ir a la gestión del menú',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
                    colorText: const Color(0xFF4B0082),
                  );
                  // DefaultTabController handles navigation to menu tab
                  break;
                case 'orders':
                  Get.snackbar(
                    'Navegación',
                    'Ir a la gestión de órdenes',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
                    colorText: const Color(0xFF4B0082),
                  );
                  // DefaultTabController handles navigation to orders tab
                  break;
                case 'info':
                  Get.snackbar(
                    'Próximamente',
                    'Navegar a la página de información del restaurante',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
                    colorText: const Color(0xFF4B0082),
                  );
                  break;
                case 'logout':
                  _showLogoutConfirmationDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'menu',
                child: Row(
                  children: [
                    Icon(Icons.restaurant_menu, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Gestión de Menú', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'orders',
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Gestión de Órdenes', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'info',
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Mi Información', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            color: Colors.white.withOpacity(0.95), // Slightly transparent white background for menu
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 8,
          ),
        ],
      ),
      body: Container(
        // Full-screen gradient background
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
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              // Spacer to push content below the transparent AppBar
              const SizedBox(height: 100),
              Container(
                color: Colors.transparent, // Keep container transparent
                child: const TabBar(
                  labelColor: Colors.white, // Active tab text color
                  unselectedLabelColor: Colors.white70, // Inactive tab text color
                  indicatorColor: Colors.white, // Underline indicator color
                  indicatorSize: TabBarIndicatorSize.tab, // Indicator covers the entire tab
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  tabs: [
                    Tab(text: 'Menú', icon: Icon(Icons.restaurant_menu)),
                    Tab(text: 'Órdenes', icon: Icon(Icons.receipt_long)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Pestaña de Menú
                    _buildMenuTab(),
                    // Pestaña de Órdenes
                    _buildOrdersTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets for Tabs and Dialogs (Visual Enhancements Applied) ---

  Widget _buildMenuTab() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Slightly transparent white background for the tab content
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), // Rounded top corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20), // Increased padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center, // Center the add button
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFF4B0082)), // Icon in purple
              label: const Text(
                'Agregar Nuevo Plato',
                style: TextStyle(color: Color(0xFF4B0082), fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF40E0D0), // Teal background
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // More rounded button
                elevation: 5,
              ),
              onPressed: () => _showAddEditDishDialog(),
            ),
          ),
          const SizedBox(height: 20), // Increased spacing
          Expanded(
            child: Obx(() {
              if (menuItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.food_bank_outlined, size: 80, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        '¡Tu menú está vacío!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Agrega tus deliciosos platos para empezar.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12), // More margin
                    elevation: 5, // Card elevation
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded card corners
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.fastfood, color: Color(0xFF4B0082), size: 30), // Purple food icon
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                ),
                                Text(
                                  '\$${item.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF40E0D0)), // Teal price
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.description,
                                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Color(0xFF40E0D0)), // Teal edit icon
                                onPressed: () => _showAddEditDishDialog(item: item),
                                tooltip: 'Editar plato',
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent), // RedAccent delete icon
                                onPressed: () => _deleteDishDialog(item),
                                tooltip: 'Eliminar plato',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Slightly transparent white background for the tab content
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), // Rounded top corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        // Placeholder for orders tab if empty
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox, size: 80, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'No hay órdenes pendientes por ahora.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              '¡Relájate, esperamos que pronto lleguen nuevas solicitudes!',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      // Original ListView structure (commented out, uncomment and populate with real data when ready)
      /*
      child: ListView.builder(
        itemCount: 0, // TODO: Reemplazar con lista real de órdenes
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ExpansionTile(
              leading: const Icon(Icons.receipt_long, color: Color(0xFF4B0082)), // Order icon
              title: const Text('Orden #123', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4B0082))),
              subtitle: const Text('Estado: Pendiente', style: TextStyle(color: Colors.orange)), // Status color
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cliente: Nombre del Cliente', style: TextStyle(fontSize: 15, color: Colors.black87)),
                      const SizedBox(height: 8),
                      Text('Detalles de la Orden:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 8),
                      // Lista de items en la orden (example)
                      const ListTile(
                        dense: true,
                        title: Text('Nombre del Plato', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: Text('x1', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const ListTile(
                        dense: true,
                        title: Text('Otro Plato', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: Text('x2', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Divider(height: 20, thickness: 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4B0082))),
                          Text('\$XX.XX', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4B0082))),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.check_circle, color: Colors.white),
                              label: const Text('Aceptar', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                // TODO: Implementar aceptar orden
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.cancel, color: Colors.white),
                              label: const Text('Rechazar', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                // TODO: Implementar rechazar orden
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      */
    );
  }

  void _showAddEditDishDialog({MenuItem? item}) {
    final nameController = TextEditingController(text: item?.name ?? '');
    final priceController = TextEditingController(text: item?.price.toString() ?? '');
    final descriptionController = TextEditingController(text: item?.description ?? '');

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Rounded dialog
        backgroundColor: Colors.transparent, // Make dialog background transparent to show inner container color
        child: Container(
          padding: const EdgeInsets.all(25), // Increased padding
          decoration: BoxDecoration(
            gradient: const LinearGradient( // Gradient background for the dialog
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF4B0082), // Dark purple
                Color(0xFF6A0DAD), // Slightly lighter purple
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item == null ? 'Agregar Plato Nuevo' : 'Editar Plato Existente', // More descriptive title
                style: const TextStyle(
                    color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), // Larger, bolder title
              ),
              const SizedBox(height: 25), // Increased spacing
              _buildTextField(nameController, 'Nombre del Plato', Icons.food_bank),
              const SizedBox(height: 15),
              _buildTextField(priceController, 'Precio', Icons.attach_money, TextInputType.number),
              const SizedBox(height: 15),
              _buildTextField(descriptionController, 'Descripción', Icons.description),
              const SizedBox(height: 30), // Increased spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, // White text
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xFF40E0D0)), // Teal border
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF40E0D0), // Teal background
                        foregroundColor: Color(0xFF4B0082), // Purple text
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                      ),
                      onPressed: () {
                        final name = nameController.text.trim();
                        final price = double.tryParse(priceController.text) ?? 0.0;
                        final description = descriptionController.text.trim();

                        if (name.isEmpty || price <= 0) {
                          Get.snackbar(
                            'Error de Validación', // More specific error
                            'Por favor, ingresa un nombre y un precio válido (mayor que 0).',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withOpacity(0.9),
                            colorText: Colors.white,
                          );
                          return;
                        }

                        final newItem = MenuItem(
                          id: item?.id ?? DateTime.now().toString(),
                          name: name,
                          price: price,
                          description: description,
                        );

                        if (item != null) {
                          final index = menuItems.indexWhere((element) => element.id == item.id);
                          if (index != -1) {
                            menuItems[index] = newItem;
                          }
                        } else {
                          menuItems.add(newItem);
                        }

                        Get.back();
                        Get.snackbar(
                          '¡Éxito!',
                          item == null ? 'Plato agregado correctamente' : 'Plato actualizado correctamente',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF40E0D0).withOpacity(0.9),
                          colorText: const Color(0xFF4B0082),
                        );
                      },
                      child: Text(
                        item == null ? 'Guardar Plato' : 'Actualizar Plato', // More descriptive button text
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for consistent text fields in dialog
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      cursorColor: const Color(0xFF40E0D0), // Teal cursor
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 16),
        prefixIcon: Icon(icon, color: Colors.white70), // Icon inside text field
        filled: true,
        fillColor: Colors.white.withOpacity(0.1), // Slightly transparent fill
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF40E0D0), width: 1.5), // Teal border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white, width: 2), // White border on focus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  void _deleteDishDialog(MenuItem item) {
    Get.defaultDialog(
      title: "Confirmar Eliminación",
      titleStyle: const TextStyle(color: Color(0xFF4B0082), fontWeight: FontWeight.bold),
      middleText: "¿Estás seguro que deseas eliminar '${item.name}' de tu menú? Esta acción no se puede deshacer.",
      middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      backgroundColor: Colors.white,
      radius: 15,
      buttonColor: Colors.redAccent, // Red for delete action
      textConfirm: "Sí, Eliminar",
      textCancel: "Cancelar",
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF4B0082),
      onConfirm: () {
        Get.back(); // Close dialog
        menuItems.removeWhere((element) => element.id == item.id);
        Get.snackbar(
          '¡Eliminado!',
          'El plato "${item.name}" ha sido eliminado correctamente.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.9),
          colorText: Colors.white,
        );
      },
      onCancel: () {
        Get.back(); // Close dialog
      },
    );
  }

  void _showLogoutConfirmationDialog() {
    Get.defaultDialog(
      title: "Confirmar Cierre de Sesión",
      titleStyle: const TextStyle(color: Color(0xFF4B0082), fontWeight: FontWeight.bold),
      middleText: "¿Estás seguro que deseas cerrar tu sesión como restaurante?",
      middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      backgroundColor: Colors.white,
      radius: 15,
      buttonColor: const Color(0xFF40E0D0),
      textConfirm: "Sí, cerrar sesión",
      textCancel: "Cancelar",
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF4B0082),
      onConfirm: () {
        Get.back(); // Close the dialog
        _authController.logout(); // Perform logout
      },
      onCancel: () {
        Get.back(); // Close the dialog
      },
    );
  }
}