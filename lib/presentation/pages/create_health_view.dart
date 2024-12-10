import 'package:flutter/material.dart';
import 'package:petuco/main.dart';

class CreateHealthView extends StatelessWidget {
  const CreateHealthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255), size: 48),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          
          title: const Text(
            'Health Test',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE1E1E1),
            ),
          ),
          backgroundColor: const Color(0xFF1B96F4),
          centerTitle: true,
              bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2),
            child: Container(
              color: Colors.white,
              height: 2,
            ),
          ),
          actions: [
            IconButton(
              icon: Image.asset('assets/images/logo.png'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage())),
            ),
          ],
        ),
        body: Container(
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
        ));
  }
}
