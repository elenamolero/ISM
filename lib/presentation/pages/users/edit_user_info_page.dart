import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/usecases/impl/get_user_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/save_user_info_use_case.dart';
import 'package:petuco/presentation/blocs/users/get_user_info_bloc.dart';
import 'package:petuco/presentation/blocs/users/save_user_info_bloc.dart';
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit User'),
          backgroundColor: Colors.blue,
        ),
        body: BlocListener<SaveUserInfoBloc, SaveUserInfoState>(
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
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          prefixIcon: const Icon(Icons.home),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Construir objeto User con valores editados
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
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 18),
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
      ),
    );
  }
}
