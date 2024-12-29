import 'package:flutter/material.dart';
import 'package:petuco/presentation/pages/common/home_page.dart';
import 'package:petuco/presentation/pages/common/login_page.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class BackGround extends StatelessWidget {
  final String title;
  final bool? home;
  final Widget? page;
  final bool isUserLoggedIn;
  final bool showAppBar;

  const BackGround({
    super.key,
    required this.title,
    this.home,
    this.page,
    required this.isUserLoggedIn,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: showAppBar
          ? AppBar(
              leading: (home ?? true)
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 48),
                      onPressed: () {
                        if (page != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => page ?? Container()),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.login_outlined,
                          color: Colors.white, size: 48),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Logout Confirmation'),
                              content: const Text(
                                  'Are you sure you want to log out?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    Supabase.instance.client.auth.signOut();
                                    print(Supabase.instance.client.auth.currentUser ??
                                        'User logged out');
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                      (route) => false,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE1E1E1),
                ),
              ),
              backgroundColor: const Color(0xFF1B96F4),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: Container(color: Colors.white, height: 2),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    onPressed: () {
                      if (isUserLoggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeUserPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Debes iniciar sesión primero')),
                        );
                      }
                    },
                    icon: Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ],
            )
          : null, // Si `showAppBar` es falso, no muestra el `AppBar`
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/footPrint.png'),
            fit: BoxFit.cover,
          ),
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
    );
  }
}
