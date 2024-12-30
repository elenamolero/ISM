import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/usecases/impl/login_user_use_case.dart';
import 'package:petuco/presentation/pages/common/home_page.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/text_button_widget.dart';
import '../../../../presentation/blocs/users/login_user_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';

class LoginUserPage extends StatefulWidget {
  const LoginUserPage({super.key});

  @override
  LoginUserPageState createState() => LoginUserPageState();
}

class LoginUserPageState extends State<LoginUserPage> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginUserBloc(loginUserUseCase: appInjector.get<LoginUserUseCase>()),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(title: 'Login',isUserLoggedIn: false,),
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: const Opacity(
                opacity: 0.69,
                child: AutoSizeText(
                  "We were waiting for you ...",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: String.fromEnvironment('InriaSans'),
                  ),
                  textAlign: TextAlign.center,
                  minFontSize: 12,
                  stepGranularity: 1,
                ),
              ),
            ),
            BlocListener<LoginUserBloc, LoginUserState>(
              listener: (context, state) {
                if (state is LoginUserSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeUserPage(), // Main page after login
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login successful!'),
                    ),
                  );
                } else if (state is LoginUserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<LoginUserBloc, LoginUserState>(
                builder: (context, state) {
                  if (state is LoginUserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const SizedBox(height: 150),
                          // Background Card
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
                                      // Email Input
                                      const CustomText(text: 'Email'),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'user@example.com',
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFA4A4A4),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFA4A4A4),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.email,
                                            color: Colors.grey,
                                          ),
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            borderSide: BorderSide.none,
                                          ),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                        ),
                                        onChanged: (value) => context
                                            .read<LoginUserBloc>()
                                            .add(UpdateEmailEvent(value)),
                                      ),
                                      const SizedBox(height: 8),
                                      const CustomText(text: 'Password'),
                                      TextField(
                                        obscureText: isObscure,
                                        decoration: InputDecoration(
                                          hintText: '••••••••',
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFA4A4A4),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFA4A4A4),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isObscure = !isObscure;
                                              });
                                            },
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            vertical: 16.0,
                                            horizontal: 12.0,
                                          ),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            borderSide: BorderSide.none,
                                          ),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                        ),
                                        onChanged: (value) => context
                                            .read<LoginUserBloc>()
                                            .add(UpdatePasswordEvent(value)),
                                      ),
                                      const SizedBox(height: 16),
                                      Center(
                                        child: SizedBox(
                                          width: 224,
                                          child: TextButtonWidget(
                                            buttonText: 'Login',
                                            function: () {
                                              context
                                                  .read<LoginUserBloc>()
                                                  .add(SubmitLoginEvent());
                                            },
                                          )
                                        ),
                                      ),
                                    ],
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
}
