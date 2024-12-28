import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:petuco/di/dependency_injection.dart';
<<<<<<< HEAD
import 'package:petuco/presentation/pages/Login_page.dart';
import 'package:petuco/presentation/pages/create_health_view.dart';
import 'package:petuco/presentation/pages/create_pet_info_page.dart';
import 'package:petuco/presentation/pages/home_page.dart';
import 'package:petuco/presentation/pages/pet_medical_historial_page.dart';
import 'package:petuco/presentation/pages/users/edit_user_info_page.dart';
import 'package:petuco/presentation/pages/users/register_user_page.dart';
import 'package:petuco/presentation/pages/login_page.dart';
=======
import 'package:petuco/presentation/pages/common/Login_page.dart';
>>>>>>> a87c391e3a920f9e5a94426bc6d1df7b5d92eadc
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petuco/presentation/pages/common/pet_info_page.dart';
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

