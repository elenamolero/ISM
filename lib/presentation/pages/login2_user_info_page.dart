import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_user.dart';
import '../blocs/users/login_user_bloc.dart';
import 'dart:ui';

class Login2UserPage extends StatefulWidget {
  const Login2UserPage({super.key});

  @override
  _Login2UserPageState createState() => _Login2UserPageState();
}

class _Login2UserPageState extends State<Login2UserPage> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => UserBloc(LoginUser()),
      child: Stack(
        children: [
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1292F2),
                    Color(0xFF5AB8FF),
                    Color(0xFF69CECE),
                  ],
                  stops: [0.1, 0.551, 1.0],
                ),
              ),
            ),
          ),
          // Main Content
          Scaffold(
            backgroundColor: Colors.transparent, // Transparent background
            body: BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserLoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pet info saved successfully!'),
                    ),
                  );
                } else if (state is UserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          width: screenWidth * 0.8, // Responsive card width
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.53),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  obscureText: _isObscured,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscured
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscured = !_isObscured;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: SizedBox(
                                    width: screenWidth * 0.6,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<UserBloc>().add(
                                              LoginUserEvent(
                                                'arvipe@hotmail.com',
                                                '1234',
                                              ),
                                            );
                                      }, // I dont understand this logic
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            97, 187, 255, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                      ),
                                      child: const Text(
                                        'Login',
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
                  );
                },
              ),
            ),
          ),
          // AppBar Section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: AppBar(
                centerTitle: true,
                toolbarHeight: 80,
                title: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.blue,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                ],
                shape: const Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
