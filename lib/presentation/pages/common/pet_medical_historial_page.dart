import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petuco/presentation/pages/vet/create_health_view.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/healthTest.entity.dart';
import 'package:petuco/domain/usecases/impl/get_health_tests_use_case.dart';
import 'package:petuco/presentation/blocs/healthTests/get_health_tests_bloc.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';

const String _petname = "Fentanyl Jr.";

class PetMedicalHistorialPage extends StatefulWidget {
 
  static const String route = 'petHistory';
 
  final int petId;

  const PetMedicalHistorialPage({Key? key, required this.petId}) : super(key: key);


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
      )..add(FetchHealthTests(petId: widget.petId)),
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(title: 'History',isUserLoggedIn: true,),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.13),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Opacity(
                    opacity: 0.69,
                    child: Text(
                      "Informes médicos de $_petname",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white.withOpacity(0.53),
                        fontWeight: FontWeight.bold,
                        fontFamily: const String.fromEnvironment('InriaSans'),
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
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: FooterWidget(),
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
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
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
                padding: const EdgeInsets.all(8.0),
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
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
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
    return GestureDetector(
      onTap: _onNewHealthTestPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.add,
              color: Color(0xFF4B8DAF),
              size: 50.0,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'New Health Test',
            style: TextStyle(
              color: const Color(0xFF4B8DAF),
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  void _onNewHealthTestPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateHealthView(petId: widget.petId,),
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
                  '• TYPE: ${healthTest.testName}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '• DESCRIPTION: ${healthTest.description}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '• DATE: ${DateFormat.yMMMd().format(healthTest.date)}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '• PLACE: ${healthTest.place}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
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