import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import '../../../domain/usecases/update_pet_info.dart';
import '../blocs/pets/update_pet_info_bloc.dart';
import '../../domain/entity/pet.entity.dart';
import 'dart:ui';

class UpdatePetInfoPage extends StatelessWidget {
  final int id;
  final String name;
  final int age;
  final String type;
  final String breed;
  final String ownerEmail;
  final String? photo;

  UpdatePetInfoPage({
    Key? key,
    required this.id,
    required this.name,
    required this.age,
    required this.type,
    required this.breed,
    required this.ownerEmail,
    this.photo,
  }) : super(key: key);

  // Controllers for the input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ownerEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with initial values
    _nameController.text = name;
    _ageController.text = age.toString();
    _typeController.text = type;
    _breedController.text = breed;
    _ownerEmailController.text = ownerEmail;

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
                  Navigator.pop(context); // Return to previous page
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
                                      const Text('Name',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      TextField(
                                        controller: _nameController,
                                        decoration: _inputDecoration(
                                            'Enter pet name', Icons.pets),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text('Owner',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      TextField(
                                        controller: _ownerEmailController,
                                        decoration: _inputDecoration(
                                            'Enter owner email', Icons.email),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text('Age',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      TextField(
                                        controller: _ageController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration(
                                            'Enter pet age',
                                            Icons.calendar_today),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text('Type',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      TextField(
                                        controller: _typeController,
                                        decoration: _inputDecoration(
                                            'Enter pet type', Icons.pets),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text('Breed',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      TextField(
                                        controller: _breedController,
                                        decoration: _inputDecoration(
                                            'Enter pet breed',
                                            Icons.star_border_outlined),
                                      ),
                                      const SizedBox(height: 8),
                                      // Save Changes Button
                                      Center(
                                        child: SizedBox(
                                          width: 224,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Collect updated data and send to the BLoC
                                              context
                                                  .read<UpdatePetInfoBloc>()
                                                  .add(
                                                    UpdatePetEvent(
                                                      Pet(
                                                        id: id,
                                                        name: _nameController
                                                            .text,
                                                        ownerEmail:
                                                            _ownerEmailController
                                                                .text,
                                                        age: int.tryParse(
                                                                _ageController
                                                                    .text) ??
                                                            0,
                                                        type: _typeController
                                                            .text,
                                                        breed: _breedController
                                                            .text,
                                                        photo: photo,
                                                      ),
                                                    ),
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
                                                  height: 2),
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

  // Helper method for consistent InputDecoration
  InputDecoration _inputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.bold),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: Icon(icon, color: Colors.grey),
    );
  }
}
