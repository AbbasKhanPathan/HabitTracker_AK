import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.background,
      content: TextField(
        controller: controller,
        style: TextStyle(color: theme.colorScheme.onBackground),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.6)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onBackground),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onBackground),
          ),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onCancel,
          color: theme.colorScheme.primary,
          child: Text("Cancel", style: TextStyle(color: theme.colorScheme.onBackground)),
        ),
        MaterialButton(
          onPressed: onSave,
          color: theme.colorScheme.secondary,
          child: Text("Save", style: TextStyle(color: theme.colorScheme.onBackground)),
        ),
      ],
    );
  }
}
