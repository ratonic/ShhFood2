// lib/widgets/panic_button_card.dart

import 'package:flutter/material.dart';
import '../../models/panic_button_model.dart';

class PanicButtonCard extends StatelessWidget {
  final PanicButtonModel button;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const PanicButtonCard({
    super.key,
    required this.button,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            // El círculo grande
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Color(button.color),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      button.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Iconos de policía/ambulancia (si están activos)
            Positioned(
              bottom: 8,
              left: 16,
              child: Row(
                children: [
                  if (button.alertToPolice)
                    const Icon(Icons.local_police, color: Colors.white70, size: 20),
                  if (button.alertToPolice && button.alertToAmbulance)
                    const SizedBox(width: 8),
                  if (button.alertToAmbulance)
                    const Icon(Icons.local_hospital, color: Colors.white70, size: 20),
                ],
              ),
            ),

            // Botón eliminar
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: onDelete,
                customBorder: CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, color: Colors.white70, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
