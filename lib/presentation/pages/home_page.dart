import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
import 'package:petuco/domain/usecases/impl/get_pets_home_use_case.dart';
import 'package:petuco/presentation/blocs/pets/get_pets_home.dart';

class HomeUserPage extends StatelessWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetBloc(getPetsUseCase: appInjector.get<GetPetsHomeUseCase>())..add(FetchPets(ownerEmail: 'ele@gmail.com')),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          title: const Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'assets/icon/petUCOLogo.png',
                height: 40,
                width: 40,
              ),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1292F2), Color(0xFF5AB8FF), Color(0xFF69CECE)],
            ),
          ),
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
      ),
    );
  }

  Widget _buildPetList(List<Pet> pets) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: const Icon(Icons.pets, color: Colors.blue, size: 40),
            title: Text(
              pet.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('name: ${pet.name}'),
            onTap: () {
              // Manejo de tap en la tarjeta
            },
          ),
        );
      },
    );
  }
}
