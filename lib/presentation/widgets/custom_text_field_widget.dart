import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final VoidCallback? onTap; // Callback para cuando se toca el campo

  const CustomTextField({
    super.key,
    required this.labelText,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
    required this.icon,
    this.onTap, // Asignar el onTap para cuando se toque el campo
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      onTap: onTap, // Solo se activa en el caso de la fecha
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFFA4A4A4),
          fontWeight: FontWeight.w400,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never, // Evita que se mueva la etiqueta
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(icon, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
      ),
    );
  }
}