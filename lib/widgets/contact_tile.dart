// lib/widgets/contact_tile.dart
import 'package:flutter/material.dart';
import '../models/contact_model.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext ctx) {
    return ListTile(
      leading: Icon(Icons.message, color: Colors.green),
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(icon: Icon(Icons.edit),  onPressed: onEdit),
        IconButton(icon: Icon(Icons.delete),onPressed: onDelete),
      ]),
    );
  }
}
