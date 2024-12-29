import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:petuco/presentation/pages/common/pet_info_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import '../../../../domain/usecases/update_pet_info.dart';
import '../../blocs/pets/update_pet_info_bloc.dart';
import '../../../domain/entities/pet.entity.dart';
import 'dart:ui';

class UpdatePetInfoPage extends StatefulWidget {
  final int petId;

  const UpdatePetInfoPage({super.key, required this.petId});

  @override
  _UpdatePetInfoPageState createState() => _UpdatePetInfoPageState();
}

class _UpdatePetInfoPageState extends State<UpdatePetInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ownerController = TextEditingController();
  final _ageController = TextEditingController();
  final _typeController = TextEditingController();
  final _breedController = TextEditingController();
  bool _nfcController = false;
  File? _imageFile;
  String? _currentImageUrl;
  bool _isFieldsPopulated = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ownerController.dispose();
    _ageController.dispose();
    _typeController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _populateFields(Pet pet) {
    _nameController.text = pet.name;
    _ownerController.text = pet.ownerEmail;
    _ageController.text = pet.age.toString();
    _typeController.text = pet.type;
    _breedController.text = pet.breed;
    _currentImageUrl = pet.photo;
    _nfcController = pet.nfcConnection!;
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;

    return BlocProvider(
      create: (_) => UpdatePetInfoBloc(
        updatePetInfo: UpdatePetInfo(
          PetRepositoryImpl(
            petsService: PetsService(),
          ),
        ),
        repository: PetRepositoryImpl(
          petsService: PetsService(),
        ),
      )..add(LoadPetEvent(widget.petId)),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(
              title: 'Update Pet Info',
              isUserLoggedIn: true,
            ),
            BlocConsumer<UpdatePetInfoBloc, UpdatePetInfoState>(
              listener: (context, state) {
                if (state is UpdatePetSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pet info updated successfully!'),
                    ),
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PetInfoPage(petId: widget.petId))
                  );
                  
                } else if (state is UpdatePetError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is PetLoaded && !_isFieldsPopulated) {
                  _populateFields(state.pet);
                  _isFieldsPopulated = true;
                }
                return Padding(
                  padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: kToolbarHeight + MediaQuery.of(context).padding.top,
                      bottom: isKeyboardOpen ? 0 : 50),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
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
                                  padding: const EdgeInsets.all(40.0),
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
                                        label: 'Owner',
                                        controller: _ownerController,
                                        icon: Icons.person_outlined,
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
                                      const SizedBox(height: 20),
                                      Center(
                                        child: Column(
                                          children: [
                                            if (_imageFile != null)
                                              Image.file(
                                                _imageFile!,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              )
                                            else if (_currentImageUrl != null)
                                              Image.network(
                                                _currentImageUrl!,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ElevatedButton(
                                              onPressed: _pickImage,
                                              child: const Text('Change Image'),
                                            ),
                                          ],
                                        ),
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
                                                    .read<UpdatePetInfoBloc>()
                                                    .add(
                                                      UpdatePetEvent(
                                                        Pet(
                                                          id: widget.petId,
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
                                                              _currentImageUrl,
                                                          nfcConnection:
                                                              _nfcController,
                                                        ),
                                                        _imageFile,
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
                                            child: state is UpdatePetLoading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white)
                                                : const Text(
                                                    'Update Pet',
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
                          SizedBox(height: isKeyboardOpen ? 30 : 50)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 60,
              left: 0,
              right: 0,
              child: const FooterWidget(),
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
