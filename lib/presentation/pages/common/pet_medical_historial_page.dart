import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petuco/presentation/pages/common/pet_info_page.dart';
import 'package:petuco/presentation/pages/vet/create_health_view.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/healthTest.entity.dart';
import 'package:petuco/domain/usecases/impl/get_health_tests_use_case.dart';
import 'package:petuco/presentation/blocs/healthTests/get_health_tests_bloc.dart';
import 'package:petuco/presentation/widgets/custom_cards_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class PetMedicalHistorialPage extends StatefulWidget {
  static const String route = 'petHistory';
  final int petId;
  final String petName;

  const PetMedicalHistorialPage({super.key, required this.petId, required this.petName});

  @override
  State<PetMedicalHistorialPage> createState() => _PetMedicalHistorialPageState();
}

class _PetMedicalHistorialPageState extends State<PetMedicalHistorialPage> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String petname = widget.petName;
    String role = Supabase.instance.client.auth.currentUser?.userMetadata!['role'] as String;

    return BlocProvider(
      create: (context) => HealthTestBloc(
        getHealthTestsUseCase: appInjector.get<GetHealthTestsUseCase>(),
      )..add(FetchHealthTests(petId: widget.petId)),
      child: Scaffold(
        body: Stack(
          children: [
            BackGround(title: 'History', isUserLoggedIn: true, page: PetInfoPage(petId: widget.petId, userRole: role)),
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
                      "Informes médicos de $petname",
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
                              _buildHealthTestsList(healthTestState.healthTests, screenWidth, role),
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
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FooterWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthTestsList(List<HealthTest> healthTests, double screenWidth, String? role) {
    return Column(
      children: List.generate(healthTests.length + 1, (index) {
        bool isSelected = _selectedIndex == index;
        double scale = isSelected ? 0.9 : 1.0;

        if (index == 0 && role == 'vet') {
          return CustomCard(
            screenWidth: screenWidth,
            isSelected: isSelected,
            scale: scale,
            child: _buildNewHealthTestContainer(screenWidth),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateHealthView(petId: widget.petId, petName: widget.petName),
                ),
              );
            },
          );
        }

        if (index > 0 && index <= healthTests.length) {
          final healthTest = healthTests[index - 1];
          return CustomCard(
            screenWidth: screenWidth,
            isSelected: isSelected,
            scale: scale,
            child: _buildHealthTestContainer(healthTest, screenWidth),
            onTap: () => setState(() => _selectedIndex = index),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }

  Widget _buildNewHealthTestContainer(double screenWidth) {
    return Row(
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
    );
  }

  Widget _buildHealthTestContainer(HealthTest healthTest, double screenWidth) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHealthTestDetail('TYPE', healthTest.testName, screenWidth),
          _buildHealthTestDetail('DESCRIPTION', healthTest.description, screenWidth),
          _buildHealthTestDetail('DATE', DateFormat.yMMMd().format(healthTest.date), screenWidth),
          _buildHealthTestDetail('PLACE', healthTest.place, screenWidth),
        ],
      ),
    );
  }

  Widget _buildHealthTestDetail(String label, String value, double screenWidth) {
    return CustomText(
      text: '• $label: $value',
      fontSize: screenWidth * 0.035,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF065591),
    );
  }
}