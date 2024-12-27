import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color color;
  final VoidCallback? function;

  const TextButtonWidget({
    super.key,
    required this.buttonText,
    this.color = const Color.fromRGBO(97, 187, 255, 1),
    this.function
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          height: 2,
        ),
      ),
    );
  }
}
