import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/user.entity.dart' as user;
import 'package:petuco/domain/usecases/impl/register_user_use_case.dart';
import 'package:petuco/presentation/blocs/users/register_user_bloc.dart';
import 'package:petuco/presentation/pages/common/login_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_field_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/text_button_widget.dart';

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
  String? _selectedValue = 'owner';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();
  final _cifController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _cifController.dispose();
    super.dispose();
  }

  bool _isObscure = true;
  bool _isConfirmObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserInfoBloc(
        registerUserInfoUseCase: appInjector.get<RegisterUserInfoUseCase>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(title: 'User register', isUserLoggedIn: false),
            BlocListener<RegisterUserInfoBloc, RegisterUserInfoState>(
              listener: (context, state) {
                if (state is RegisterUserSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You were successfully registered')),
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
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: kToolbarHeight + MediaQuery.of(context).padding.top,
                    ),
                    child: KeyboardAvoider(
                      autoScroll: true,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40),
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
                                        const CustomText(
                                          text: 'Name',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        CustomTextField(
                                          labelText: 'Name',
                                          controller: _nameController,
                                          icon: Icons.person,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'enter your name';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        const CustomText(
                                          text: 'Email',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        CustomTextField(
                                          labelText: 'Email',
                                          controller: _emailController,
                                          icon: Icons.email,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return ' enter your email';
                                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                              return ' enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        const CustomText(
                                          text: 'Password',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        CustomTextField(
                                          labelText: 'Password',
                                          controller: _passwordController,
                                          icon: Icons.lock,
                                          keyboardType: TextInputType.visiblePassword,
                                          obscureText: _isObscure,
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
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return ' enter a password';
                                            } else if (value.length < 8) {
                                              return ' must be at least 8 characters long';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        const CustomText(
                                          text: 'Confirm Password',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        CustomTextField(
                                          labelText: 'Confirm Password',
                                          controller: _confirmPasswordController,
                                          icon: Icons.lock,
                                          keyboardType: TextInputType.visiblePassword,
                                          obscureText: _isConfirmObscure,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isConfirmObscure ? Icons.visibility_off : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isConfirmObscure = !_isConfirmObscure;
                                              });
                                            },
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'confirm your password';
                                            } else if (value != _passwordController.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        const CustomText(
                                          text: 'Phone Number',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        CustomTextField(
                                          labelText: 'Phone Number',
                                          controller: _phoneController,
                                          icon: Icons.phone,
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'enter your phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        const CustomText(
                                          text: 'Address',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        CustomTextField(
                                          labelText: 'Address',
                                          controller: _addressController,
                                          icon: Icons.home,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'enter your address';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        const CustomText(
                                          text: 'Role',
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
                                          items: ["vet", "owner"].map((name) {
                                            return DropdownMenuItem(value: name, child: Text(name));
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedValue = value;
                                              _showVet = _selectedValue == 'vet';
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        Visibility(
                                          visible: _showVet,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const CustomText(
                                                text: 'Company',
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                              CustomTextField(
                                                labelText: 'Company',
                                                controller: _companyController,
                                                icon: Icons.business,
                                                validator: (value) {
                                                  if (_showVet && (value == null || value.isEmpty)) {
                                                    return 'enter your company';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 8),
                                              const CustomText(
                                                text: 'CIF',
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                              CustomTextField(
                                                labelText: 'CIF',
                                                controller: _cifController,
                                                icon: Icons.document_scanner_outlined,
                                                validator: (value) {
                                                  if (_showVet && (value == null || value.isEmpty)) {
                                                    return 'enter your CIF';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Center(
                                          child: SizedBox(
                                            width: 224,
                                            child: TextButtonWidget(buttonText: "Register", function: () => _registerUser(context)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40)
                            ],
                          ),
                        ),
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
    if (_formKey.currentState?.validate() ?? false) {
      final newUser = user.User(
        name: _nameController.text,
        email: _emailController.text,
        address: _addressController.text,
        phoneNumber: int.tryParse(_phoneController.text) ?? 0,
        password: _passwordController.text,
        role: _selectedValue ?? 'owner',
        company: _showVet ? _companyController.text : null,
        cif: _showVet ? _cifController.text : null,
      );

      context.read<RegisterUserInfoBloc>().add(RegisterUserEvent(newUser));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}
