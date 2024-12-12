import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1292F2),
              Color(0xFF5AB8FF),
              Color(0xFF69CECE),
            ],
            stops: [0.1, 0.551, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.05,
              left: (screenWidth - screenWidth * 1.08) / 2,
              child: Image.asset(
                'assets/images/whiteLogo.png',
                width: screenWidth * 1.04,
                height: screenHeight * 0.55,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: screenHeight * 0.55,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: const Opacity(
                opacity: 0.69, 
                child: AutoSizeText(
                  "Manage your pets' history with us;\nwe'll keep it safe with care.",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: String.fromEnvironment('InriaSans'),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  minFontSize: 12,
                  stepGranularity: 1,
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.10,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Opacity(
                    opacity: 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón Login
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(screenWidth * 0.8, 50),
                        backgroundColor: const Color(0xFF61BBFF),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white, // Color blanco
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Opacity(
                    opacity: 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón Register
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(screenWidth * 0.8, 50),
                        backgroundColor: const Color(0xFF65D389),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
