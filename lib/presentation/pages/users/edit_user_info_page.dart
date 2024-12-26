import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/usecases/impl/get_user_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/save_user_info_use_case.dart';
import 'package:petuco/presentation/blocs/users/get_user_info_bloc.dart';
import 'package:petuco/presentation/blocs/users/save_user_info_bloc.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_field_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../domain/entities/user.dart' as user;

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({super.key});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController roleController;

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
    super.dispose();
  }

  bool _isObscure = true;
  bool _isObscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetUserInfoBloc(getUserInfoUseCase: appInjector.get<GetUserInfoUseCase>())..add(GetUserEvent(Supabase.instance.client.auth.currentUser!.email!)),
        ),
        BlocProvider(
          create: (_) => SaveUserInfoBloc(saveUserInfoUseCase: appInjector.get<SaveUserInfoUseCase>()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:Stack(
        children: [
          const BackGround(title: 'Edit User Info'),
          BlocListener<SaveUserInfoBloc, SaveUserInfoState>(
          listener: (context, state) {
            if (state is SaveUserSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User info saved successfully!')),
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
                final userInfo = state.userInfo;
                nameController.text = userInfo.name;
                emailController.text = userInfo.email;
                addressController.text = userInfo.address;
                phoneNumberController.text = userInfo.phoneNumber.toString();
                passwordController.text = userInfo.password;
                confirmPasswordController.text = userInfo.password;
                roleController.text = userInfo.role;
              } else if (state is GetUserError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              return Padding(
                padding: EdgeInsets.only(
                  left: 40, 
                  right: 40,
                  top: kToolbarHeight+MediaQuery.of(context).padding.top,
                  bottom: 50),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: 'Name'
                                ),
                                CustomTextField(
                                  labelText: 'Name',
                                  controller: nameController,
                                  icon: Icons.person
                                ),
                                const SizedBox(height: 8),

                                const CustomText(
                                  text: 'Email'
                                ),
                                CustomTextField(
                                  labelText: 'Email',
                                  controller: emailController,
                                  icon: Icons.email,
                                ),
                                const SizedBox(height: 8),

                                const CustomText(
                                  text: 'Address'
                                ),
                                CustomTextField(
                                  labelText: 'Address',
                                  controller: addressController,
                                  icon: Icons.home,
                                ),
                                const SizedBox(height: 8),

                                const CustomText(
                                  text: 'Phone Number'
                                ),
                                CustomTextField(
                                  labelText: 'Phone Number',
                                  controller: phoneNumberController,
                                  icon: Icons.email,
                                ),

                                const SizedBox(height: 8),
                                const CustomText(
                                  text: 'Password'
                                ),
                                CustomTextField(
                                  obscureText: _isObscure,
                                  controller: passwordController,
                                  labelText: 'Password',
                                  icon: Icons.email,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure ? Icons.visibility_off : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure; // Alterna el estado
                                        });
                                      },
                                    ),
                                ),

                                const SizedBox(height: 8),
                                const CustomText(
                                  text: 'Confirm Password'
                                ),
                                CustomTextField(
                                  obscureText: _isObscureConfirm,
                                  controller: confirmPasswordController,
                                  labelText: 'Password',
                                  icon: Icons.email,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscureConfirm = !_isObscureConfirm; // Alterna el estado
                                        });
                                      },
                                    ),
                                )
                              ],
                            )
                            )
                        )
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Center(
                        child: SizedBox(
                          width: 224,
                          child: ElevatedButton(
                            onPressed: () {
                              if (passwordController.text != confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Passwords do not match')),
                                );
                                return;
                              }
                              final updatedUser = user.User(
                              name: nameController.text,
                              email: emailController.text,
                              address: addressController.text,
                              phoneNumber: int.tryParse(phoneNumberController.text) ?? 0,
                              password: passwordController.text,
                              role: roleController.text,
                            );
                            context.read<SaveUserInfoBloc>().add(
                                  SaveUserEvent(updatedUser),
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
                          )
                        )
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            },
          ),
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
}