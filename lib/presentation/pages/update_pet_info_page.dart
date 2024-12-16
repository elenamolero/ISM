import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import '../../../domain/usecases/update_pet_info.dart';
import '../blocs/pets/update_pet_info_bloc.dart';
import '../../domain/entity/pet.entity.dart';
import 'dart:ui';

class UpdatePetInfoPage extends StatelessWidget {
  const UpdatePetInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdatePetInfoBloc(UpdatePetInfo()),
      child: Scaffold(
        body: Stack(
          children: [
              const BackGround(title: 'Update Pet Info'),
             
           BlocListener<UpdatePetInfoBloc, UpdatePetInfoState>(
                listener: (context, state) {
                  if (state is UpdatePetSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pet info saved successfully!'),
                      ),
                    );
                  } else if (state is UpdatePetError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: BlocBuilder<UpdatePetInfoBloc, UpdatePetInfoState>(
                  builder: (context, state) {
                    if (state is UpdatePetLoading) {
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
                                            labelStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: const Icon(
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
                                        const SizedBox(height: 8),

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
                                            labelStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: const Icon(
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
                                        const SizedBox(height: 8),

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
                                            labelStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: const Icon(
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
                                        const SizedBox(height: 8),

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
                                            labelStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            suffixIcon: const Icon(
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
                                        const SizedBox(height: 8),

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
                                        const SizedBox(height: 8),
                                        // Save Changes Button
                                        Center(
                                          child: SizedBox(
                                            width: 224,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Send event to the BLoC
                                                context
                                                    .read<UpdatePetInfoBloc>()
                                                    .add(
                                                      UpdatePetEvent(Pet(
                                                        name: 'Drako',
                                                        ownerEmail: 'arvipe@hotmail.com',
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
            ],
            ),
          ),
    );
  }
}
