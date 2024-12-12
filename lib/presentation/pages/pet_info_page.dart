import 'package:flutter/material.dart';
import 'package:petuco/presentation/pages/background_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:ui';
import 'package:petuco/presentation/pages/update_pet_info_page.dart';

class PetInfoPage extends StatefulWidget {
  const PetInfoPage({super.key});

  @override
  PetInfoPageState createState() => PetInfoPageState();
}

class PetInfoPageState extends State<PetInfoPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          const BackGround(title: 'Pet Info'),

          // Header Text
          Positioned(
            top: screenHeight * 0.14,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: const Opacity(
              opacity: 0.69,
              child: AutoSizeText(
                "This is animal's data",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: String.fromEnvironment('InriaSans'),
                ),
                textAlign: TextAlign.center,
                minFontSize: 12,
                stepGranularity: 1,
              ),
            ),
          ),

          // Main content (form)
          Positioned(
            top: screenHeight * 0.35,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.53),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pet info
                        Center(
                          child: SizedBox(
                            width: 224,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const UpdatePetInfoPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(97, 187, 255, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Edit data',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  height: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // History Button
          Positioned(
            bottom: 110,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Center(
              child: SizedBox(
                width: 224,
                child: ElevatedButton(
                  onPressed: () {
                    // Redirigir al historial de la mascota
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(166, 23, 219, 99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'History',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Footer Line
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              height: 2,
              color: Colors.white,
            ),
          ),

          // Person Icon
          Positioned(
            bottom: 20, 
            left: 0,  
            right: 0,  
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF69CECE),
                shape: BoxShape.circle, 
                border: Border.all(color: Colors.white, width: 3), 
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
