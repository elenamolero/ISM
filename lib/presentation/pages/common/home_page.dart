import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import 'package:petuco/domain/usecases/impl/get_pets_home_use_case.dart';
import 'package:petuco/domain/usecases/impl/get_user_info_use_case.dart';
import 'package:petuco/presentation/blocs/pets/get_pets_home.dart';
import 'package:petuco/presentation/blocs/users/get_user_info_bloc.dart';
import 'package:petuco/presentation/pages/owner/create_pet_info_page.dart';
import 'package:petuco/presentation/pages/common/pet_info_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String email = Supabase.instance.client.auth.currentUser!.email!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PetBloc(
            getPetsUseCase: appInjector.get<GetPetsHomeUseCase>(),
          )..add(FetchPets(ownerEmail: email)),
        ),
        BlocProvider(
          create: (context) => GetUserInfoBloc(
            getUserInfoUseCase: appInjector.get<GetUserInfoUseCase>(),
          )..add(GetUserEvent(email)),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(title: 'Home',home: false, isUserLoggedIn: true,),
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              bottom: screenHeight * 0.1,
              child: BlocBuilder<GetUserInfoBloc, GetUserInfoState>(
                builder: (context, userState) {
                  return BlocBuilder<PetBloc, PetState>(
                    builder: (context, petState) {
                      if (petState is PetLoading ||
                          userState is GetUserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (petState is PetLoaded &&
                          userState is GetUserSuccess) {
                        final userName = userState.userInfo.name;
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Welcome $userName,',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Which pet do you want to manage today?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(158, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildPetList(
                                  petState.pets, screenWidth, userName),
                              const SizedBox(height: 40), // Espacio adicional
                            ],
                          ),
                        );
                      } else if (petState is PetError) {
                        return Center(
                          child: Text(
                            petState.message,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        );
                      } else if (userState is GetUserError) {
                        return Center(
                          child: Text(
                            userState.message,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        );
                      }
                      return const Center(
                        child: Text(
                          'Welcome! Fetching your pets...',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Positioned(
              bottom: -2,
              left: 0,
              right: 0,
              child: FooterWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetList(List<Pet> pets, double screenWidth, String userName) {
    return Column(
      children: List.generate(pets.length + 1, (index) {
        bool isSelected = _selectedIndex == index;
        double scale = isSelected ? 0.9 : 1.0;

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
                child: _buildNewPetContainer(screenWidth),
              ),
            ),
          );
        } else {
          final pet = pets[index - 1];
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
                child: _buildPetContainer(pet, screenWidth, userName,context),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildNewPetContainer(double screenWidth) {
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
                    'New Pet',
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreatePetInfoPage(),
          ),
        );
      },
    );
  }

  Widget _buildPetContainer(Pet pet, double screenWidth, String userName,context) {
    String role = Supabase.instance.client.auth.currentUser?.userMetadata!['role'] as String;

    return ListTile(
      title: Row(
        children: [
          if (pet.photo != null)
            Container(
              width: screenWidth * 0.2,
              height: screenWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  pet.photo!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Icon(Icons.pets, color: Color(0xFF065591), size: 40),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    
                  ),
                ),
                Text(
                  '• Age: ${pet.age}',
                  style: TextStyle(
                    color: const Color(0xFF065591),
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                Text(
                  '• Owner: $userName',
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetInfoPage(petId: pet.id, userRole: role),
          ),
        );
      },
    );
  }
}
