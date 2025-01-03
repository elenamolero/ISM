import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/presentation/pages/common/home_page.dart';
import 'package:petuco/presentation/pages/owner/nfc_connection_view.dart';
import 'package:petuco/presentation/pages/common/pet_medical_historial_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/presentation/pages/owner/update_pet_info_page.dart';
import 'package:petuco/domain/usecases/impl/get_pet_info_use_case.dart';
import 'package:petuco/presentation/blocs/pets/get_pet_info_bloc.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:petuco/presentation/widgets/text_button_widget.dart';

class PetInfoPage extends StatefulWidget {
  final int petId;
  final String? userRole;
  const PetInfoPage({super.key, required this.petId, required this.userRole});

  @override
  State<PetInfoPage> createState() => _PetInfoPageState();
}

class _PetInfoPageState extends State<PetInfoPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PetBloc(
            getPetUseCase: appInjector.get<GetPetInfoUseCase>(),
          )..add(FetchPet(petId: widget.petId)),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(
                title: 'Pet Info', isUserLoggedIn: true, page: HomeUserPage()),
            Padding(
              padding: EdgeInsets.only(
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
                bottom: isKeyboardOpen ? 0 : 50,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    BlocBuilder<PetBloc, PetState>(
                      builder: (context, petState) {
                        String titleText = "Fetching pet's data...";
                        if (petState is PetLoaded) {
                          titleText = "This is ${petState.pet.name}'s data";
                        }
                        return Opacity(
                          opacity: 0.69,
                          child: AutoSizeText(
                            titleText,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: String.fromEnvironment('InriaSans'),
                            ),
                            textAlign: TextAlign.center,
                            minFontSize: 12,
                            stepGranularity: 1,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Main Content Container
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.53),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: BlocBuilder<PetBloc, PetState>(
                              builder: (context, petState) {
                                if (petState is PetLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (petState is PetLoaded) {
                                  final pet = petState.pet;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Centering the pet image
                                      Center(
                                        child: Container(
                                          width: screenWidth * 0.3,
                                          height: screenWidth * 0.3,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: pet.photo != null
                                                ? Image.network(
                                                    pet.photo!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : const Icon(
                                                    Icons.pets,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Text inside a box aligned to the left but centered on screen
                                      Container(
                                        alignment: Alignment.center,
                                        width: screenWidth * 0.8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '• Name: ${pet.name}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF065591)),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '• Sex: ${pet.sex}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF065591)),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '• Age: ${pet.age}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF065591)),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '• Type: ${pet.type}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF065591)),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '• Breed: ${pet.breed}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF065591)),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '• Owner email: ${pet.ownerEmail}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF065591)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (widget.userRole == 'owner') ...[
                                        const SizedBox(height: 20),
                                        SizedBox(
                                            width: 220,
                                            child: TextButtonWidget(
                                              buttonText: "Edit Data",
                                              function: () => _GoButton(pet.id,context),
                                            )),
                                      ],
                                    ],
                                  );
                                } else if (petState is PetError) {
                                  return Center(
                                    child: Text(
                                      petState.message,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: Text(
                                    'Fetching pet data...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.userRole == 'vet' ||
                        widget.userRole == 'owner') ...[
                      SizedBox(height: screenHeight * 0.03),
                      SizedBox(
                        width: 220,
                        child: BlocBuilder<PetBloc, PetState>(
                          builder: (context, petState) {
                            String buttonText = "History";
                            if (petState is PetLoaded) {
                              buttonText = "${petState.pet.name}'s history";
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (petState is PetLoaded) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PetMedicalHistorialPage(
                                              petId: petState.pet.id,
                                              petName: petState.pet.name),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(97, 187, 255, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                buttonText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: screenHeight * 0.02),
                    if (widget.userRole == 'owner') ...[
                      SizedBox(
                        width: 220,
                        child: BlocBuilder<PetBloc, PetState>(
                          builder: (context, petState) {
                            String buttonText = "NFC management";
                            return ElevatedButton(
                              onPressed: () {
                                if (petState is PetLoaded) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NfcConnectionView(
                                          petId: petState.pet.id),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(166, 23, 219, 99),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                buttonText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: screenHeight * 0.15),
                  ],
                ),
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
      ),
    );
  }

  void _GoButton(id,context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdatePetInfoPage(
            petId: id,
          ),
        ));
  }
}
