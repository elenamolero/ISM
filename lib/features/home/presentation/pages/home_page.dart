import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/features/home/presentation/bloc/get_pets_home.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  /*DESCOMENTAR CUANDO SE TENGA LA CONEXION A LA BD
  Future<Map<List<String>, dynamic>?> fetchPetsData() async {
  return await Supabase.instance.client
      .from('Pet')
      .select('name')
      .execute();
  }

  Map<List<String>, dynamic>? data;

   @override
  void initState() {
    super.initState();
  }

  void loadUserData() async {
      data = await fetchPetsData();
      setState(() {});
    }
*/
//CAMBIAR CUANDO SE TENGA LA CONEXION A LA BD
  Future<List<String>> fetchPetsData() async {
    // Simula una llamada a la base de datos
    await Future.delayed(const Duration(seconds: 2));
    return ['Pet 1', 'Pet 2', 'Pet 3']; // Reemplaza con tu lógica de obtención de datos
  }
//////////////////////////////////////////////7
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80, // Adjust this value to increase the height
        title: const Center(
          child: Padding(
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
            color: Colors.white, // Set the border color to white
            width: 2.0, // Set the border width
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
          padding: const EdgeInsets.all(80),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100), // Push inputs down
                Container(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome Elena,', //CAMBIAR POR EL NOMBRE DEL USUARIO
                        textAlign: TextAlign.center, // Centra el texto
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255), // Color del texto
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0, // Ajusta el tamaño del texto según sea necesario
                        ),
                      ),
                      SizedBox(height: 10), // Espacio entre los textos
                      Text(
                        'which pet do you want to manage today?',
                        textAlign: TextAlign.center, // Centra el texto
                        style: TextStyle(
                          color: Color.fromARGB(158, 255, 255, 255), // Color del texto
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0, // Ajusta el tamaño del texto según sea necesario
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // new pet button
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(91, 255, 255, 255),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 43, 101, 131),
                              size: 50.0, // Ajusta el tamaño según sea necesario
                            ),
                            Text(
                              'New pet',
                              textAlign: TextAlign.center, // Centra el texto
                              style: TextStyle(
                                color: Color.fromARGB(255, 43, 101, 131), // Color del texto
                                fontSize: 20.0, // Ajusta el tamaño del texto según sea necesario
                                fontWeight: FontWeight.bold, // Pone el texto en negrita
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), 

                FutureBuilder<List<String>>(
                  future: fetchPetsData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading data'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No pets found'));
                    }

                    final data = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(91, 255, 255, 255),
                              ),
                              padding: const EdgeInsets.all(16.0), // Padding dentro del contenedor
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.pets,
                                    color: Color.fromARGB(255, 43, 101, 131),
                                    size: 50.0, 
                                  ),
                                  const SizedBox(width: 10), // Espacio entre el icono y el texto
                                  Expanded(
                                    child: Text(
                                      '- Name: ${data[index]}',
                                      textAlign: TextAlign.center, // Centra el texto
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 43, 101, 131), // Color del texto
                                        fontSize: 20.0, 
                                        fontWeight: FontWeight.bold, 
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20), 
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}