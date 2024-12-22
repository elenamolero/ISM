import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/user.dart' as user;
import 'package:petuco/domain/usecases/impl/register_user_use_case.dart';
import 'package:petuco/presentation/blocs/users/register_user_bloc.dart';

import 'package:petuco/presentation/widgets/background_widget.dart';

final outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: BorderSide.none,
);

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  bool _showVet = false;
  String? _selectedValue;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();
  final _cifController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _cifController.dispose();
    super.dispose();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserInfoBloc(
        registerUserInfoUseCase: appInjector.get<RegisterUserInfoUseCase>(),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(title: 'Registro de usuario'),
            BlocListener<RegisterUserInfoBloc, RegisterUserInfoState>(
              listener: (context, state) {
                if (state is RegisterUserSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuario registrado exitosamente')),
                  );
                } else if (state is RegisterUserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<RegisterUserInfoBloc, RegisterUserInfoState>(
                builder: (context, state) {
                  if (state is RegisterUserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.53),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        hintText: 'Name',
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
                                          Icons.person,
                                          color: Colors.grey,
                                        ),
                                        border: outlineInputBorder,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
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
                                          Icons.email,
                                          color: Colors.grey,
                                        ),
                                        border: outlineInputBorder,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Password',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextField(
                                      obscureText: _isObscure,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
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
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure ? Icons.visibility_off : Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        ),
                                        border: outlineInputBorder,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Phone Number',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextField(
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                        hintText: 'Phone Number',
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
                                          Icons.phone,
                                          color: Colors.grey,
                                        ),
                                        border: outlineInputBorder,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Address',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextField(
                                      controller: _addressController,
                                      decoration: InputDecoration(
                                        hintText: 'Address',
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
                                          Icons.home,
                                          color: Colors.grey,
                                        ),
                                        border: outlineInputBorder,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Role',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                      ),
                                      items: ["Veterinario", "Dueño de un animal"].map((name) {
                                        return DropdownMenuItem(value: name, child: Text(name));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedValue = value;
                                          _showVet = _selectedValue == 'Veterinario';
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                    Visibility(
                                      visible: _showVet,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Company',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextField(
                                            controller: _companyController,
                                            decoration: InputDecoration(
                                              hintText: 'Company',
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
                                                Icons.business,
                                                color: Colors.grey,
                                              ),
                                              border: outlineInputBorder,
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'CIF',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextField(
                                            controller: _cifController,
                                            decoration: InputDecoration(
                                              hintText: 'CIF',
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
                                                Icons.document_scanner_outlined,
                                                color: Colors.grey,
                                              ),
                                              border: outlineInputBorder,
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: SizedBox(
                              width: 224,
                              child: ElevatedButton(
                                onPressed: () {
                                  _registerUser(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(97, 187, 255, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text(
                                  'Register',
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
          ],
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) {
    final newUser = user.User(
      name: _nameController.text,
      email: _emailController.text,
      address: _addressController.text,
      phoneNumber: int.tryParse(_phoneController.text) ?? 0,
      password: _passwordController.text,
      role: _selectedValue ?? 'Dueño de un animal',
      company: _showVet ? _companyController.text : null,
      cif: _showVet ? _cifController.text : null,
    );

    context.read<RegisterUserInfoBloc>().add(RegisterUserEvent(newUser));
  }
}