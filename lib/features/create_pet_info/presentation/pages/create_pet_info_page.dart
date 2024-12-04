import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/save_pet_info.dart';
import '../bloc/create_pet_info_bloc.dart';
import '../../domain/entities/pet.dart';

class CreatePetInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePetInfoBloc(SavePetInfo()),
      child: Stack(
        children: [
          Scaffold(
            body: Container(
              constraints: const BoxConstraints.expand(),
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
              child: BlocListener<CreatePetInfoBloc, CreatePetInfoState>(
                listener: (context, state) {
                  if (state is CreatePetSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Pet info saved successfully!')),
                    );
                  } else if (state is CreatePetError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: BlocBuilder<CreatePetInfoBloc, CreatePetInfoState>(
                  builder: (context, state) {
                    if (state is CreatePetLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Padding(
                      padding: const EdgeInsets.all(80),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                                height:
                                    100), // Add this SizedBox to push down the inputs

                            // Pet Name Input
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Pet Name',
                                prefixIcon: Icon(Icons.pets),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Owner Input
                            TextField(
                              controller: TextEditingController(
                                  text:
                                      'Luz Marina'), // Pre-fill with Luz Marina
                              decoration: InputDecoration(
                                labelText: 'Owner',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Pet Age Input
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Age',
                                prefixIcon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Pet Type Input
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Type',
                                prefixIcon: Icon(Icons.pets),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Pet Breed Input
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Breed',
                                prefixIcon: Icon(Icons.pets),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Save Changes Button
                            Center(
                              child: SizedBox(
                                width: 224, // Set the width to 224 pixels
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Send event to the BLoC
                                    context.read<CreatePetInfoBloc>().add(
                                          SavePetEvent(Pet(
                                            name: 'Drako',
                                            ownerID: 1,
                                            age: 2,
                                            type: 'Dog',
                                            breed: 'Husky',
                                          )),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(97, 187, 255, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                        color: Colors
                                            .white, // Set the border color to white
                                        width: 2.0, // Set the border width
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  child: const Text(
                                    'Save Changes',
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
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              centerTitle: true,
              toolbarHeight: 80, // Adjust this value to increase the height
              title: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Create Pet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
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
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                side: BorderSide(
                  color: Colors.white, // Set the border color to white
                  width: 2.0, // Set the border width
                ),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
