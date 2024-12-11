import 'package:flutter/material.dart';
import 'package:petuco/presentation/pages/create_pet_info_page.dart';
import 'package:petuco/presentation/pages/register_user_page.dart';
import 'package:petuco/presentation/pages/update_pet_info_page.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'petUco',
      debugShowCheckedModeBanner: false,
      //  builder: (context, child) => CreatePetInfoPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 183, 58, 58)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 54),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePetInfoPage(),
                    ),
                  );
                },
                child: const Text('Go to Create Pet Info'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdatePetInfoPage(),
                    ),
                  );
                },
                child: const Text('Go to Update Pet Info'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterUserPage(),
                    ),
                  );
                },
                child: const Text('Go to Update Pet Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
