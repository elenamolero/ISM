import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/usecases/impl/get_user_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/save_user_info_use_case.dart';
import 'package:petuco/presentation/blocs/users/get_user_info_bloc.dart';
import 'package:petuco/presentation/blocs/users/save_user_info_bloc.dart';
import 'package:petuco/presentation/pages/background_page.dart';
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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Liberar los controladores
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetUserInfoBloc(getUserInfoUseCase: appInjector.get<GetUserInfoUseCase>())..add(GetUserEvent('arvipe@hotmail.com')),
        ),
        BlocProvider(
          create: (_) => SaveUserInfoBloc(saveUserInfoUseCase: appInjector.get<SaveUserInfoUseCase>()),
        ),
      ],
      child: Scaffold(
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
              } else if (state is GetUserError) {
                return Center(child: Text('Error: ${state.message}'));
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
                                  controller: nameController,
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
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),

                                TextField(
                                  controller: emailController,
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
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                                const Text(
                                  'Address',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),

                                TextField(
                                  controller: addressController,
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
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                                const Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),

                                TextField(
                                  controller: phoneNumberController,
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
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                                const Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                      
                                TextField(
                                  obscureText: _isObscure,
                                  controller: passwordController,
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
                                          _isObscure = !_isObscure; // Alterna el estado
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
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
                              final updatedUser = user.User(
                              name: nameController.text,
                              email: emailController.text,
                              address: addressController.text,
                              phoneNumber: int.tryParse(phoneNumberController.text) ?? 0,
                              password: passwordController.text,
                              role: 'user', // Actualiza según sea necesario
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
                      )
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



