import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double screenWidth;
  final bool isSelected;
  final double scale;
  final Widget child;
  final VoidCallback onTap;

  const CustomCard({
    Key? key,
    required this.screenWidth,
    required this.isSelected,
    required this.scale,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: scale,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white.withOpacity(0.53),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}