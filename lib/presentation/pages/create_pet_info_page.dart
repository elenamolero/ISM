import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/data/services/model/pet_response.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import '../../../domain/usecases/save_pet_info.dart';
import '../blocs/pets/create_pet_info_bloc.dart';
import '../../domain/entity/pet.entity.dart';
import 'dart:ui';

class CreatePetInfoPage extends StatefulWidget {
  const CreatePetInfoPage({Key? key}) : super(key: key);

  @override
  _CreatePetInfoPageState createState() => _CreatePetInfoPageState();
}

class _CreatePetInfoPageState extends State<CreatePetInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ownerController = TextEditingController();
  final _ageController = TextEditingController();
  final _typeController = TextEditingController();
  final _breedController = TextEditingController();
  final _photoUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ownerController.dispose();
    _ageController.dispose();
    _typeController.dispose();
    _breedController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePetInfoBloc(
        SavePetInfo(
          PetRepositoryImpl(
            petsService: PetsService(),
          ),
        ),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(title: 'Create Pet Info'),
            BlocConsumer<CreatePetInfoBloc, CreatePetInfoState>(
              listener: (context, state) {
                if (state is CreatePetSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pet info saved successfully!'),
                    ),
                  );
                  _formKey.currentState?.reset();
                } else if (state is CreatePetError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),
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
                                      _buildTextField(
                                        label: 'Name',
                                        controller: _nameController,
                                        icon: Icons.cruelty_free_outlined,
                                      ),
                                      _buildTextField(
                                        label: 'Owner Email',
                                        controller: _ownerController,
                                        icon: Icons.email_outlined,
                                      ),
                                      _buildTextField(
                                        label: 'Age',
                                        controller: _ageController,
                                        icon: Icons.calendar_today,
                                        keyboardType: TextInputType.number,
                                      ),
                                      _buildTextField(
                                        label: 'Type',
                                        controller: _typeController,
                                        icon: Icons.pets,
                                      ),
                                      _buildTextField(
                                        label: 'Breed',
                                        controller: _breedController,
                                        icon: Icons.star_border_outlined,
                                      ),
                                      _buildTextField(
                                        label: 'Photo',
                                        controller: _photoUrlController,
                                        icon: Icons.image_outlined,
                                      ),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: SizedBox(
                                          width: 224,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                context
                                                    .read<CreatePetInfoBloc>()
                                                    .add(
                                                      SavePetEvent(
                                                        Pet(
                                                          id: 0,
                                                          name: _nameController
                                                              .text,
                                                          ownerEmail:
                                                              _ownerController
                                                                  .text,
                                                          age: int.parse(
                                                              _ageController
                                                                  .text),
                                                          type: _typeController
                                                              .text,
                                                          breed:
                                                              _breedController
                                                                  .text,
                                                          photo:
                                                              _photoUrlController
                                                                  .text,
                                                        ),
                                                      ),
                                                    );
                                              }
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
                                            child: state is CreatePetLoading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white)
                                                : const Text(
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
                          const SizedBox(height: 60), // Espacio adicional

                          
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: FooterWidget(),
                      ),
          ],
          
        ),
        
      ),
      
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: Icon(
              icon,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            if (label == 'Age' && int.tryParse(value) == null) {
              return 'Please enter a valid age';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
