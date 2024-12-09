import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  Future<List<String>> fetchPetsData() async {
  try {
    final response = await Supabase.instance.client.from('Pet').select('name');
    debugPrint('Response from Supabase: $response'); // Muestra la respuesta completa
    
    // Verifica si la respuesta tiene datos y luego mapea
    if (response != null && response.isNotEmpty) {
      return response.map<String>((pet) => pet['name'] as String).toList();
    } else {
      debugPrint('No pets found in response');
      return [];
    }
  } catch (error) {
    debugPrint('Error fetching pets: $error');  // Muestra el error
    return [];
  }
}


  @override
  Widget build(BuildContext context) {
    debugPrint('Building HomeUserPage');  // Verifica si la página se está construyendo correctamente.

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
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
                'assets/icon/petUCOLogo.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          side: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        elevation: 0,
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Welcome Elena,', // Cambiar por el nombre del usuario
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Which pet do you want to manage today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(158, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Acción para agregar nueva mascota
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(91, 255, 255, 255),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 43, 101, 131),
                        size: 50.0,
                      ),
                      Text(
                        'New Pet',
                        style: TextStyle(
                          color: Color.fromARGB(255, 43, 101, 131),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<String>>(
                  future: fetchPetsData(),
                  builder: (context, snapshot) {
                    debugPrint('Snapshot state: ${snapshot.connectionState}'); // Imprimir estado de la conexión
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Error loading pets.',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      debugPrint('No pets found or empty data');  // Imprimir cuando no haya datos
                      return const Center(
                        child: Text(
                          'No pets found.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    final pets = snapshot.data!;
                    debugPrint('Fetched pets: $pets');  // Imprimir los pets obtenidos

                    return ListView.builder(
                      itemCount: pets.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(91, 255, 255, 255),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.pets,
                                color: Color.fromARGB(255, 43, 101, 131),
                                size: 50.0,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '- Name: ${pets[index]}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 43, 101, 131),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
