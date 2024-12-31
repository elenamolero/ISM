import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/presentation/pages/common/home_page.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/text_button_widget.dart';
import 'package:petuco/presentation/blocs/users/forgot_user_bloc.dart'; // Create this BLoC
import 'package:auto_size_text/auto_size_text.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';

class ForgotUserPage extends StatefulWidget {
  const ForgotUserPage({super.key});

  @override
  ForgotUserPageState createState() => ForgotUserPageState();
}

class ForgotUserPageState extends State<ForgotUserPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          ForgotUserBloc(appInjector.get()), // Inject your use case here
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(title: 'Forgot Username', isUserLoggedIn: false),
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: const Opacity(
                opacity: 0.69,
                child: AutoSizeText(
                  "Retrieve your username with your registered email",
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
            BlocListener<ForgotUserBloc, ForgotUserState>(
              listener: (context, state) {
                if (state is ForgotUserSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Username sent to ${state.email}!')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeUserPage()),
                  );
                } else if (state is ForgotUserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<ForgotUserBloc, ForgotUserState>(
                builder: (context, state) {
                  if (state is ForgotUserLoading) {
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
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                      ),
                                      onChanged: (value) => context
                                          .read<ForgotUserBloc>()
                                          .add(UpdateEmailEvent(value)),
                                    ),
                                    const SizedBox(height: 16),
                                    Center(
                                      child: SizedBox(
                                        width: 224,
                                        child: TextButtonWidget(
                                          buttonText: 'Retrieve Username',
                                          function: () {
                                            context
                                                .read<ForgotUserBloc>()
                                                .add(SubmitForgotUserEvent());
                                          },
                                        ),
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
