import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/usecases/impl/get_pet_info_use_case.dart';
import 'package:petuco/presentation/pages/common/pet_info_page.dart';
import 'package:petuco/presentation/pages/common/register_user_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_field_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:petuco/presentation/widgets/text_button_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/usecases/impl/update_pet_info_use_case.dart';
import '../../blocs/pets/update_pet_info_bloc.dart';
import '../../../domain/entities/pet.entity.dart';

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
  final _sexController = TextEditingController();
  final _ageController = TextEditingController();
  final _typeController = TextEditingController();
  final _breedController = TextEditingController();
  bool _nfcController = false;
  File? _imageFile;
  String? _currentImageUrl;
  bool _isFieldsPopulated = false;
  String? _selectedValue = 'female'; 

  @override
  void dispose() {
    _nameController.dispose();
    _ownerController.dispose();
    _sexController.dispose();
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
    _sexController.text = pet.sex;
    _ageController.text = pet.age.toString();
    _typeController.text = pet.type;
    _breedController.text = pet.breed;
    _currentImageUrl = pet.photo;
    _nfcController = pet.nfcConnection!;
    _selectedValue = pet.sex;
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;
    String role = Supabase.instance.client.auth.currentUser?.userMetadata!['role'] as String;

    return BlocProvider(
      create: (_) => UpdatePetInfoBloc(
        updatePetInfo: appInjector.get<UpdatePetInfoUseCase>(),
        getPetInfoUseCase: appInjector.get<GetPetInfoUseCase>(),
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
                    MaterialPageRoute(builder: (context) => PetInfoPage(petId: widget.petId, userRole: role))
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
                                      const CustomText(
                                        text: 'Name',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      CustomTextField(
                                        labelText: 'Name',
                                        controller: _nameController,
                                        icon: Icons.cruelty_free_outlined,
                                      ),
                                      const SizedBox(height: 8),
                                      const CustomText(
                                        text: 'Sex',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: _selectedValue, 
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: outlineInputBorder,
                                        ),
                                        items: ["female", "male"].map((name) {
                                          return DropdownMenuItem(value: name, child: Text(name));
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedValue = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      const CustomText(
                                        text: 'Age',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      CustomTextField(
                                        labelText: 'Age',
                                        controller: _ageController,
                                        icon: Icons.cake,
                                      ),
                                      const SizedBox(height: 8),
                                      const CustomText(
                                        text: 'Type',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      CustomTextField(
                                        labelText: 'Type',
                                        controller: _typeController,
                                        icon: Icons.pets,
                                      ),
                                      const SizedBox(height: 8),
                                      const CustomText(
                                        text: 'Breed',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      CustomTextField(
                                        labelText: 'Breed',
                                        controller: _breedController,
                                        icon: Icons.star_border_outlined,
                                      ),
                                      const SizedBox(height: 8),
                                      const CustomText(
                                        text: 'Photo',
                                        fontSize: 18,
                                        color: Colors.white,
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
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: SizedBox(
                                          width: 224,
                                          child: TextButtonWidget(
                                            function: _pickImage,
                                            buttonText: 'Change Image',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: SizedBox(
                                          width: 224,
                                          child: TextButtonWidget(
                                            function: () {
                                              if (_formKey.currentState ?.validate() ?? false) {
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
                                                      sex: _sexController
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
                                            buttonText: 'Update Pet'
                                          ),
                                        ),
                                      ),
                                    ],
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
}
