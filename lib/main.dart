import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/presentation/pages/asign_pet_page.dart';
import 'package:petuco/presentation/pages/create_health_view.dart';
import 'package:petuco/presentation/pages/create_pet_info_page.dart';
import 'package:petuco/presentation/pages/home_page.dart';
import 'package:petuco/presentation/pages/nfc_connection_view.dart';
import 'package:petuco/presentation/pages/pet_medical_historial_page.dart';
import 'package:petuco/presentation/pages/users/edit_user_info_page.dart';
import 'package:petuco/presentation/pages/users/register_user_page.dart';
import 'package:petuco/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petuco/presentation/pages/pet_info_page.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    initInjection();
    if (kIsWeb) {
      //setUrlStrategy(PathUrlStrategy());
    }
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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue, // Fondo común
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');
        print('Navigated to: ${uri.pathSegments}'); // Debugging

        if (kIsWeb) {
          // Handle deep link for web

          if (uri.pathSegments.length == 2 &&
              uri.pathSegments[0] == 'infopet') {
            final id = int.tryParse(uri.pathSegments[1]);
            if (id != null) {
              return MaterialPageRoute(
                builder: (context) => PetInfoPage(petId: id),
              );
            }
          }
          // Fallback to 404 page for web
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text("404 Page not found"),
              ),
            ),
          );
        } else {
          // Handle for non-web platforms (default)
          return MaterialPageRoute(
            builder: (context) =>  const LoginPage(),
          );
        }
      },
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
                      builder: (context) => const HomeUserPage(),
                    ),
                  );
                },
                child: const Text('Go to Home page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditUserInfoPage(),
                    ),
                  );
                },
                child: const Text('Go to Profile'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterUserPage()),
                  );
                },
                child: const Text("Go to register page"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text('Go to Login page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateHealthView(
                        petId: 1,
                      ),
                    ),
                  );
                },
                child: const Text('Go to Create Health View'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditUserInfoPage(),
                    ),
                  );
                },
                child: const Text('Go to Edit user Info page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PetMedicalHistorialPage(petId: 1),
                    ),
                  );
                },
                child: const Text('Go to Medical Historial Pet'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NfcConectionView()));
                },
                child: const Text("Go to Nfc conection view"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
