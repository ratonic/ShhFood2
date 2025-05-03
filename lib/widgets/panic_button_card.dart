// lib/widgets/panic_button_card.dart

import 'package:flutter/material.dart';
import '../../models/panic_button_model.dart';

class PanicButtonCard extends StatelessWidget {
  final PanicButtonModel button;
  final VoidCallback onDelete;
  final VoidCallback? onTap; // <- nuevo parámetro opcional

  const PanicButtonCard({
    super.key,
    required this.button,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(button.color),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap, // ahora responde al tap
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          button.title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            if (button.alertToPolice) const Icon(Icons.local_police, color: Colors.white70, size: 20),
            if (button.alertToPolice && button.alertToAmbulance) const SizedBox(width: 8),
            if (button.alertToAmbulance) const Icon(Icons.local_hospital, color: Colors.white70, size: 20),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
