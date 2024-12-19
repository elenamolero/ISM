import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/presentation/pages/pet_medical_historial_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:ui';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/presentation/pages/update_pet_info_page.dart';
import 'package:petuco/domain/usecases/impl/get_pet_info_use_case.dart';
import 'package:petuco/presentation/blocs/pets/get_pet_info_bloc.dart';

class PetInfoPage extends StatefulWidget {
  final int petId;

  const PetInfoPage({Key? key, required this.petId}) : super(key: key);

  @override
  State<PetInfoPage> createState() => _PetInfoPageState();
}

class _PetInfoPageState extends State<PetInfoPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PetBloc(
            getPetUseCase: appInjector.get<GetPetInfoUseCase>(),
          )..add(FetchPet(petId: widget.petId)),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            // Background
            const BackGround(title: 'Pet Info'),

            // Header Text
            Positioned(
              top: screenHeight * 0.13,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, petState) {
                  String titleText = "Fetching pet's data...";
                  if (petState is PetLoaded) {
                    titleText = "This is ${petState.pet.name}'s data";
                  }
                  return Opacity(
                    opacity: 0.69,
                    child: AutoSizeText(
                      titleText,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: String.fromEnvironment('InriaSans'),
                      ),
                      textAlign: TextAlign.center,
                      minFontSize: 12,
                      stepGranularity: 1,
                    ),
                  );
                },
              ),
            ),

            // Main content (centered content with left-aligned text)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.53),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: BlocBuilder<PetBloc, PetState>(
                        builder: (context, petState) {
                          if (petState is PetLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (petState is PetLoaded) {
                            final pet = petState.pet;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Pet Data (centered text with left-aligned text)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ${pet.name}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Age: ${pet.age}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Type: ${pet.type}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Breed: ${pet.breed}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Owner email: ${pet.ownerEmail}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Image (centered)
                                Center(
                                  child: pet.imageUrl != null
                                      ? Image.network(
                                          pet.imageUrl!,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.pets,
                                          size: 80,
                                          color: Colors.grey,
                                        ),
                                ),
                                const SizedBox(height: 20),
                                // Edit Button
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final pet = petState.pet;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePetInfoPage(
                                                id: pet.id,
                                                name: pet.name,
                                                age: pet.age,
                                                type: pet.type,
                                                breed: pet.breed,
                                                ownerEmail: pet.ownerEmail,
                                                imageUrl: pet.imageUrl,
                                              ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          97, 187, 255, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                    ),
                                    child: const Text(
                                      'Edit data',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (petState is PetError) {
                            return Center(
                              child: Text(
                                petState.message,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: Text(
                              'Fetching pet data...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // History Button
            Positioned(
              bottom: 80,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PetMedicalHistorialPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(166, 23, 219, 99),
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
                        fontSize: 16,
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
              bottom: 40,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                color: Colors.white,
              ),
            ),

            // Person Icon
            Positioned(
              bottom: 10,
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
      ),
    );
  }
}
