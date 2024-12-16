import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/usecases/impl/get_health_tests_use_case.dart';
import 'package:petuco/presentation/blocs/healthTests/get_health_tests_bloc.dart';
import 'package:petuco/presentation/pages/background_page.dart';

const String _petname = "Fentanyl Jr.";

class PetMedicalHistorialPage extends StatefulWidget {
  const PetMedicalHistorialPage({Key? key}) : super(key: key);

  @override
  State<PetMedicalHistorialPage> createState() => _PetMedicalHistorialPageState();
}

class _PetMedicalHistorialPageState extends State<PetMedicalHistorialPage> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => HealthTestBloc(
        getHealthTestsUseCase: appInjector.get<GetHealthTestsUseCase>(),
      )..add(FetchHealthTests(petId: 3)),
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(title: 'History'),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.13),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Opacity(
                    opacity: 0.69,
                    child: Text(
                      "Informes médicos de $_petname",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: String.fromEnvironment('InriaSans'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<HealthTestBloc, HealthTestState>(
                    builder: (context, healthTestState) {
                      if (healthTestState is HealthTestLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (healthTestState is HealthTestLoaded) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              _buildHealthTestsList(healthTestState.healthTests, screenWidth),
                            ],
                          ),
                        );
                      } else if (healthTestState is HealthTestError) {
                        return Center(
                          child: Text(
                            healthTestState.message,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

Widget _buildHealthTestsList(List<HealthTest> healthTests, double screenWidth) {
  return Column(
    children: List.generate(healthTests.length + 1, (index) {
      bool isSelected = _selectedIndex == index;
      double scale = isSelected ? 0.9 : 1.0;

      // Caso especial para "New Health Test"
      if (index == 0) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: scale,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.53),
                boxShadow: isSelected
                    ? [
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              padding: const EdgeInsets.all(16.0),
              child: _buildNewHealthTestContainer(screenWidth),
            ),
          ),
        );
      }

      // Renderizar los healthTests
      final healthTest = healthTests[index - 1];
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.53),
              boxShadow: isSelected
                  ? [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.all(16.0),
            child: _buildHealthTestContainer(healthTest, screenWidth),
          ),
        ),
      );
    }),
  );
}


  Widget _buildNewHealthTestContainer(double screenWidth) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.2,
            height: screenWidth * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Color(0xFF4B8DAF),
                    size: 50.0,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'New Health Test',
                    style: TextStyle(
                      color: const Color(0xFF4B8DAF),
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTestContainer(HealthTest healthTest, double screenWidth) {
    return ListTile(
      title: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  healthTest.testName,
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Description: ${healthTest.description}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                Text(
                  'Date: ${DateFormat.yMMMd().format(healthTest.date)}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                Text(
                  'Place: ${healthTest.place}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
      /*
        child: Scaffold(
          body: Stack(
        children: [
          const BackGround(title: 'History'),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: screenHeight*0.13),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Opacity(
                  opacity: 0.69,
                  child: Text("Informes médicos de $_petname",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: String.fromEnvironment('InriaSans')
                      )
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    MedicalOperationBox(
                        type: 'Operacion',
                        description:
                            'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                        date: DateTime.now(),
                        place: 'Alice in the Wonderlands'),
                    MedicalOperationBox(
                        type: 'Operacion',
                        description:
                            'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                        date: DateTime.now(),
                        place: 'Alice in the Wonderlands'),
                        MedicalOperationBox(
                        type: 'Operacion',
                        description:
                            'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                        date: DateTime.now(),
                        place: 'Alice in the Wonderlands'),
                        MedicalOperationBox(
                        type: 'Operacion',
                        description:
                            'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                        date: DateTime.now(),
                        place: 'Alice in the Wonderlands')
                  ],
                ),
              ))
            ],
          )
        ],
      ));
    }
  }

  class MedicalOperationBox extends StatelessWidget {
    final String type;
    final String description;
    final DateTime date;
    final String place;

    const MedicalOperationBox({
      super.key,
      required this.type,
      required this.description,
      required this.date,
      required this.place,
    });

    @override
    Widget build(BuildContext context) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(date);
      const TextStyle textStyle = TextStyle(
        fontFamily: String.fromEnvironment('InriaSans'),
        fontSize: 14,
        color: Color.fromARGB(255, 0, 50, 92)
      );

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.53),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: textStyle,
                    children: [
                      const TextSpan(
                        text: '• TIPO: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: type),
                    ]),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                    style: textStyle,
                    children: [
                      const TextSpan(
                        text: '• DESCRIPCIÓN: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: description),
                    ]),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                    style: textStyle,
                    children: [
                      const TextSpan(
                        text: '• FECHA: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: formattedDate)
                    ]),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                    style: textStyle,
                    children: [
                      const TextSpan(
                        text: '• LUGAR: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: place),
                    ]),
              ),
            ],
          ),
        ),
      );
    }
  }*/