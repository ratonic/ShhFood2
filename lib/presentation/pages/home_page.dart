// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/panic_button_controller.dart';
import '../../models/panic_button_model.dart';
import '../../widgets/panic_button_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    final ctrl = Get.find<PanicButtonController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Botones de Pánico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authCtrl.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (ctrl.error.value.isNotEmpty) return Center(child: Text('Error: ${ctrl.error.value}'));
        if (ctrl.buttons.isEmpty) return const Center(child: Text('Aún no tienes botones'));

        return ListView.builder(
          itemCount: ctrl.buttons.length,
          itemBuilder: (_, i) {
            final btn = ctrl.buttons[i];
            return GestureDetector(
              onTap: () => _showAddEditDialog(context, ctrl, existing: btn),
              child: PanicButtonCard(
                button: btn,
                onDelete: () => ctrl.deleteButton(btn.id),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddEditDialog(context, ctrl),
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, PanicButtonController ctrl, {PanicButtonModel? existing}) {
    final titleCtrl = TextEditingController(text: existing?.title ?? '');
    int selectedColor = existing?.color ?? 0xFF2196F3;
    bool alertPolice = existing?.alertToPolice ?? false;
    bool alertAmbulance = existing?.alertToAmbulance ?? false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(existing == null ? 'Nuevo Botón' : 'Editar Botón'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Selecciona un color:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: [
                      _colorCircle(0xFF2196F3, selectedColor, () => setState(() => selectedColor = 0xFF2196F3)),
                      _colorCircle(0xFFF44336, selectedColor, () => setState(() => selectedColor = 0xFFF44336)),
                      _colorCircle(0xFF4CAF50, selectedColor, () => setState(() => selectedColor = 0xFF4CAF50)),
                      _colorCircle(0xFFFFC107, selectedColor, () => setState(() => selectedColor = 0xFFFFC107)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    value: alertPolice,
                    onChanged: (v) => setState(() => alertPolice = v ?? false),
                    title: const Text('Alertar a Policía'),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.red,
                  ),
                  CheckboxListTile(
                    value: alertAmbulance,
                    onChanged: (v) => setState(() => alertAmbulance = v ?? false),
                    title: const Text('Alertar a Ambulancia'),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final model = PanicButtonModel(
                    id: existing?.id ?? '',
                    title: titleCtrl.text.trim(),
                    color: selectedColor,
                    contactIds: existing?.contactIds ?? [],
                    alertToPolice: alertPolice,
                    alertToAmbulance: alertAmbulance,
                    userId: '',
                  );
                  if (existing == null) {
                    ctrl.addButton(model);
                  } else {
                    ctrl.updateButton(model);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(existing == null ? 'Crear' : 'Guardar'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _colorCircle(int hex, int current, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Color(hex),
        radius: 20,
        child: current == hex ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
