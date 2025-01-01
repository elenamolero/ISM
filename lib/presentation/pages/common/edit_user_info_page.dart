import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/usecases/impl/get_user_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/save_user_info_use_case.dart';
import 'package:petuco/presentation/blocs/users/get_user_info_bloc.dart';
import 'package:petuco/presentation/blocs/users/save_user_info_bloc.dart';
import 'package:petuco/presentation/pages/common/home_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/text_button_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_field_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../domain/entities/user.entity.dart' as user;

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({super.key});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController roleController;
  TextEditingController? companyController;
  TextEditingController? cifController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    roleController = TextEditingController();
    confirmPasswordController = TextEditingController();
    companyController = TextEditingController();
    cifController = TextEditingController();
  }

  @override
  void dispose() {
    // Liberar los controladores
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    roleController.dispose();
    confirmPasswordController.dispose();
    companyController?.dispose();
    cifController?.dispose();
    super.dispose();
  }

  bool _isObscure = true;
  bool _isObscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;
    String? role = Supabase
        .instance.client.auth.currentUser?.userMetadata!['role'] as String?;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetUserInfoBloc(
              getUserInfoUseCase: appInjector.get<GetUserInfoUseCase>())
            ..add(GetUserEvent(
                Supabase.instance.client.auth.currentUser!.email!)),
        ),
        BlocProvider(
          create: (_) => SaveUserInfoBloc(
              saveUserInfoUseCase: appInjector.get<SaveUserInfoUseCase>()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(
              title: 'Edit User Info',
              isUserLoggedIn: true,
            ),
            BlocListener<SaveUserInfoBloc, SaveUserInfoState>(
              listener: (context, state) {
                if (state is SaveUserSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('User info saved successfully!')),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const HomeUserPage()),
                    (route) => false,
                  );
                } else if (state is SaveUserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<GetUserInfoBloc, GetUserInfoState>(
                builder: (context, state) {
                  if (state is GetUserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetUserSuccess) {
                    if (nameController.text.isEmpty)
                      nameController.text = state.userInfo.name;
                    if (emailController.text.isEmpty)
                      emailController.text = state.userInfo.email;
                    if (addressController.text.isEmpty)
                      addressController.text = state.userInfo.address;
                    if (phoneNumberController.text.isEmpty)
                      phoneNumberController.text =
                          state.userInfo.phoneNumber.toString();
                    if (passwordController.text.isEmpty)
                      passwordController.text = state.userInfo.password;
                    if (confirmPasswordController.text.isEmpty)
                      confirmPasswordController.text = state.userInfo.password;
                    if (roleController.text.isEmpty)
                      roleController.text = state.userInfo.role;
                    if (role == 'vet') {
                      companyController ??= TextEditingController();
                      cifController ??= TextEditingController();
                      if (companyController!.text.isEmpty)
                        companyController!.text = state.userInfo.company ?? '';
                      if (cifController!.text.isEmpty)
                        cifController!.text = state.userInfo.cif ?? '';
                    }
                  } else if (state is GetUserError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }

                  return Padding(
                      padding: EdgeInsets.only(
                          left: 40,
                          right: 40,
                          top: kToolbarHeight +
                              MediaQuery.of(context).padding.top,
                          bottom: isKeyboardOpen ? 0 : 50),
                      child: KeyboardAvoider(
                        child: SingleChildScrollView(
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
                                          child: Form(
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const CustomText(
                                                      text: 'Name'),
                                                  CustomTextField(
                                                      labelText: 'Name',
                                                      controller:
                                                          nameController,
                                                      icon: Icons.person),
                                                  const SizedBox(height: 8),
                                                  const CustomText(
                                                      text: 'Email'),
                                                  CustomTextField(
                                                    enabled: false,
                                                    labelText: 'Email',
                                                    controller: emailController,
                                                    icon: Icons.email,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return ' enter your address';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const CustomText(
                                                      text: 'Address'),
                                                  CustomTextField(
                                                    controller:
                                                        addressController,
                                                    labelText: 'Address',
                                                    icon: Icons.home,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return ' enter your address';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const CustomText(
                                                      text: 'Phone Number'),
                                                  CustomTextField(
                                                    labelText: 'Phone Number',
                                                    controller:
                                                        phoneNumberController,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    icon: Icons.email,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return ' enter your phone number';
                                                      } else if (value.length !=
                                                          9) {
                                                        return ' must be 9 digits long';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const CustomText(
                                                      text: 'Password'),
                                                  CustomTextField(
                                                    obscureText: _isObscure,
                                                    controller:
                                                        passwordController,
                                                    labelText: 'Password',
                                                    icon: Icons.email,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return ' enter a password';
                                                      } else if (value.length <
                                                          8) {
                                                        return ' must be at least 8 characters long';
                                                      }
                                                      return null;
                                                    },
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _isObscure
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscure =
                                                              !_isObscure; // Alterna el estado
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const CustomText(
                                                      text: 'Confirm Password'),
                                                  CustomTextField(
                                                    obscureText:
                                                        _isObscureConfirm,
                                                    controller:
                                                        confirmPasswordController,
                                                    labelText: 'Password',
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'confirm your password';
                                                      } else if (value !=
                                                          passwordController
                                                              .text) {
                                                        return 'Passwords do not match';
                                                      }
                                                      return null;
                                                    },
                                                    icon: Icons.email,
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _isObscureConfirm
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscureConfirm =
                                                              !_isObscureConfirm; // Alterna el estado
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  if (role == 'vet') ...[
                                                    const SizedBox(height: 8),
                                                    const CustomText(
                                                        text: 'Company'),
                                                    CustomTextField(
                                                      controller:
                                                          companyController,
                                                      labelText: 'Company',
                                                      icon: Icons.business,
                                                      validator: (value) {
                                                        if ((value == null ||
                                                            value.isEmpty)) {
                                                          return 'enter your company';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const CustomText(
                                                        text: 'CIF'),
                                                    CustomTextField(
                                                      controller: cifController,
                                                      labelText: 'CIF',
                                                      icon: Icons.badge,
                                                      validator: (value) {
                                                        if ((value == null ||
                                                            value.isEmpty)) {
                                                          return 'enter your CIF';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ],
                                                ],
                                              ))))),
                              const SizedBox(height: 20),
                              Center(
                                  child: SizedBox(
                                      width: 224,
                                      child: TextButtonWidget(
                                          buttonText: 'Save changes',
                                          function: () {
                                            if (passwordController.text !=
                                                confirmPasswordController
                                                    .text) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Passwords do not match')),
                                              );
                                              return;
                                            }
                                            if (passwordController
                                                    .text.isEmpty &&
                                                confirmPasswordController
                                                    .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Password cannot be empty')),
                                              );
                                              return;
                                            }
                                            if (nameController.text.isEmpty ||
                                                emailController.text.isEmpty ||
                                                addressController
                                                    .text.isEmpty ||
                                                phoneNumberController
                                                    .text.isEmpty ||
                                                roleController.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'All fields are required')),
                                              );
                                              return;
                                            }
                                            if (passwordController.text.length <
                                                    8 &&
                                                confirmPasswordController
                                                        .text.length <
                                                    8) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Password must be at least 8 characters')),
                                              );
                                              return;
                                            }
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              final updatedUser = user.User(
                                                name: nameController.text,
                                                email: emailController.text,
                                                address: addressController.text,
                                                phoneNumber: int.tryParse(
                                                        phoneNumberController
                                                            .text) ??
                                                    0,
                                                password:
                                                    passwordController.text,
                                                role: roleController.text,
                                                company: role == 'vet'
                                                    ? companyController?.text
                                                    : null,
                                                cif: role == 'vet'
                                                    ? cifController?.text
                                                    : null,
                                              );
                                              context
                                                  .read<SaveUserInfoBloc>()
                                                  .add(
                                                    SaveUserEvent(updatedUser),
                                                  );
                                            }
                                          }))),
                              SizedBox(height: isKeyboardOpen ? 20 : 50),
                            ],
                          ),
                        ),
                      ));
                },
              ),
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
