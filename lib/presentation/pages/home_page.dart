import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
import 'package:petuco/domain/usecases/impl/get_pets_home_use_case.dart';
import 'package:petuco/presentation/blocs/pets/get_pets_home.dart';
import 'package:petuco/presentation/pages/background_page.dart';

class HomeUserPage extends StatelessWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => PetBloc(getPetsUseCase: appInjector.get<GetPetsHomeUseCase>())..add(FetchPets(ownerEmail: 'ele@gmail.com')),
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(title: 'Home'),
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, state) {
                  if (state is PetLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          'Welcome Elena,', // Cambiar por el nombre del usuario
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Which pet do you want to manage today?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(158, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPetList(state.pets),
                      ],
                    );
                  } else if (state is PetError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      'Welcome! Fetching your pets...',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetList(List<Pet> pets) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      itemCount: pets.length + 1, // Incrementa el itemCount para incluir el botón
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.53),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Color(0xFF4B8DAF),
                    size: 50.0,
                  ),
                  Text(
                    'New Pet',
                    style: TextStyle(
                      color: Color(0xFF4B8DAF),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          final pet = pets[index - 1];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.53),
              ),
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                leading: Builder(
                  builder: (context) {
                    if (pet.imageUrl != null) {
                      debugPrint('Image URL: ${pet.imageUrl}');
                      return Image.network(
                        pet.imageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      );
                    } else {
                      debugPrint('No Image URL available');
                      return const Icon(Icons.pets, color: Color(0xFF065591), size: 40);
                    }
                  },
                ),
                title: Text(
                  pet.name,
                  style: const TextStyle(
                    color: Color(0xFF065591),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${pet.name}',
                      style: const TextStyle(
                        color: Color(0xFF065591),
                      ),
                    ),
                    Text(
                      'Owner: ${pet.ownerEmail}',
                      style: const TextStyle(
                        color: Color(0xFF065591),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Manejo de tap en la tarjeta
                },
              ),
            ),
          );
        }
      },
    );
  }
}