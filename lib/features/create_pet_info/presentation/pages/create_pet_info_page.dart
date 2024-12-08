import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/save_pet_info.dart';
import '../bloc/create_pet_info_bloc.dart';
import '../../domain/entities/pet.dart';
import 'dart:ui';

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
                        content: Text('Pet info saved successfully!'),
                      ),
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
                      padding: const EdgeInsets.all(40),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            // Background Card
                            ClipRRect(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Pet Name Input
                                        const Text(
                                          'Name',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Drako',
                                            hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: Icon(
                                              Icons.cruelty_free_outlined,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 16),

                                        const Text(
                                          'Owner',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),

                                        // Owner Input
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Luz Marina',
                                            hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: Icon(
                                              Icons.person_outlined,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 16),

                                        const Text(
                                          'Age',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),

                                        // Pet Age Input
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: '2',
                                            hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: Icon(
                                              Icons.calendar_today,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 16),

                                        const Text(
                                          'Type',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),

                                        // Pet Type Input
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Dog',
                                            hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: Icon(
                                              Icons.pets,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 16),

                                        const Text(
                                          'Breed',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),

                                        // Pet Breed Input
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Husky',
                                            hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                            labelStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: const Icon(
                                              Icons.star_border_outlined,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        // Save Changes Button
                                        Center(
                                          child: SizedBox(
                                            width: 224,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Send event to the BLoC
                                                context
                                                    .read<CreatePetInfoBloc>()
                                                    .add(
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
                                                    const Color.fromRGBO(
                                                        97, 187, 255, 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
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
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
              child: AppBar(
                centerTitle: true,
                toolbarHeight: 80,
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
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                ],
                shape: const Border(
                  bottom: BorderSide(
                    color: Colors.white, // Adjust the color as needed
                    width: 2.0, // Adjust the width as needed
                  ),
                ),
                elevation: 0, // No shadow
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/images/footer.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
