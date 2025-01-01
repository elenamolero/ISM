import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/presentation/pages/common/pet_info_page.dart';
import 'package:petuco/presentation/pages/common/register_user_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_field_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:petuco/presentation/widgets/text_button_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/usecases/impl/save_pet_info_use_case.dart';
import '../../blocs/pets/create_pet_info_bloc.dart';
import '../../../domain/entities/pet.entity.dart';

class CreatePetInfoPage extends StatefulWidget {
  const CreatePetInfoPage({super.key});

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
  var createdPet;
  File? _imageFile;
  String? _selectedValue = 'female';
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

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;
    String role = Supabase
        .instance.client.auth.currentUser?.userMetadata!['role'] as String;

    return BlocProvider(
      create: (_) => CreatePetInfoBloc(appInjector.get<SavePetInfoUseCase>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(
              title: 'Create Pet Info',
              isUserLoggedIn: true,
            ),
            BlocConsumer<CreatePetInfoBloc, CreatePetInfoState>(
              listener: (context, state) {
                if (state is CreatePetSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pet info saved successfully!'),
                    ),
                  );
                  _formKey.currentState?.reset();
                  setState(() {
                    _imageFile = null;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            PetInfoPage(petId: createdPet.id, userRole: role)),
                  );
                } else if (state is CreatePetError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Padding(
                    padding: EdgeInsets.only(
                        left: 40,
                        right: 40,
                        top:
                            kToolbarHeight + MediaQuery.of(context).padding.top,
                        bottom: isKeyboardOpen ? 0 : 50),
                    child: KeyboardAvoider(
                      autoScroll: true,
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
                                    padding: const EdgeInsets.all(40),
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'enter the name';
                                            }
                                            return null;
                                          },
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
                                            return DropdownMenuItem(
                                                value: name, child: Text(name));
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
                                            keyboardType: TextInputType.number,
                                            icon: Icons.cake,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'enter the age';
                                              }
                                              else if (int.tryParse(value) == null) {
                                                return 'enter a valid number';
                                              }
                                              else if (int.tryParse(value)! < 0) {
                                                return 'enter a valid number';
                                              }
                                              return null;
                                            }),
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'enter the type';
                                              }
                                              return null;
                                            }),
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'enter the breed';
                                              }
                                              return null;
                                            }),
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
                                                ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: 224,
                                            child: TextButtonWidget(
                                              function: _pickImage,
                                              buttonText: 'Pick Image',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: SizedBox(
                                            width: 224,
                                            child: TextButtonWidget(
                                              function: () {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  createdPet = Pet(
                                                    id: DateTime.now()
                                                        .millisecondsSinceEpoch,
                                                    name: _nameController.text,
                                                    ownerEmail: Supabase
                                                        .instance
                                                        .client
                                                        .auth
                                                        .currentUser!
                                                        .email!,
                                                    sex: _selectedValue ??
                                                        'female',
                                                    age: int.parse(
                                                        _ageController.text),
                                                    type: _typeController.text,
                                                    breed:
                                                        _breedController.text,
                                                    photo: _imageFile?.path,
                                                  );
                                                  context
                                                      .read<CreatePetInfoBloc>()
                                                      .add(
                                                        SavePetEvent(
                                                          createdPet,
                                                          _imageFile,
                                                        ),
                                                      );
                                                }
                                              },
                                              buttonText: 'Save New Pet',
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
                    ));
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
