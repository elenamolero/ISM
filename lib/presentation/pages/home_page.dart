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
            // Background
            const BackGround(title: 'Home'),

            // Main content
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, state) {
                  if (state is PetLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetLoaded) {
                    return _buildPetList(state.pets);
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
          // Botón "New pet"
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.add, color: Colors.blue, size: 40),
              title: const Text(
                'New pet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Manejo de tap en el botón "New pet"
              },
            ),
          );
        } else {
          final pet = pets[index - 1]; // Ajusta el índice para las mascotas
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.pets, color: Colors.blue, size: 40),
              title: Text(
                pet.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${pet.name}'),
                  Text('Owner: ${pet.ownerEmail}'),
                ],
              ),
              onTap: () {
                // Manejo de tap en la tarjeta
              },
            ),
          );
        }
      },
    );
  }
}