import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import 'package:petuco/presentation/pages/common/home_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:petuco/presentation/blocs/pets/assign_vet_bloc.dart';
import 'package:petuco/domain/usecases/get_pets_by_owner_email.dart';
import 'package:petuco/domain/usecases/assign_vet_to_pet.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AsignPetPage extends StatefulWidget {
  @override
  _AsignPetPageState createState() => _AsignPetPageState();
}

class _AsignPetPageState extends State<AsignPetPage> {
  final TextEditingController _ownerEmailController = TextEditingController();
  final String _vetEmail = Supabase.instance.client.auth.currentUser!.email!;
  List<Pet> _selectedPets = [];

  @override
  void dispose() {
    _ownerEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AssignVetBloc(
        getPetsByOwnerEmail: GetPetsByOwnerEmail(
          PetRepositoryImpl(
            petsService: PetsService(),
          ),
        ),
        assignVetToPet: AssignVetToPet(
          PetRepositoryImpl(
            petsService: PetsService(),
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(
              title: 'Assign Pets',
              isUserLoggedIn: true,
              page: HomeUserPage(),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                right: 40,
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
                bottom: 60,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Center(
                            child: Text(
                              "Find your new client",
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildEmailInput(),
                          const SizedBox(height: 20),
                          _buildPetFetchingAndAssignment(screenWidth),
                        ],
                      ),
                    ),
                  ),
                ],
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

  Widget _buildEmailInput() {
    return TextField(
      controller: _ownerEmailController,
      decoration: InputDecoration(
        hintText: 'Enter the owner\'s email',
        suffixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPetFetchingAndAssignment(double screenWidth) {
    return BlocConsumer<AssignVetBloc, AssignVetState>(
      listener: (context, state) {
        if (state is AssignVetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully assigned to pet(s)!')),
          );
          _selectedPets.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const HomeUserPage(), // Main page after login
            ),
          );
        } else if (state is AssignVetError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: state is AssignVetLoading
                  ? null
                  : () {
                      context.read<AssignVetBloc>().add(
                            FetchPetsByOwnerEmailEvent(
                                _ownerEmailController.text),
                          );
                    },
              child: state is AssignVetLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Fetch Pets'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            if (state is PetsFetched) _buildPetList(state.pets, screenWidth),
            if (state is PetsFetched && _selectedPets.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    for (var pet in _selectedPets) {
                      context.read<AssignVetBloc>().add(
                            AssignVetToPetEvent(pet.id, _vetEmail),
                          );
                    }
                  },
                  child: const Text('Assign Selected Pets'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildPetList(List<Pet> pets, double screenWidth) {
    return Column(
      children: pets.map((pet) {
        bool isSelected = _selectedPets.contains(pet);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedPets.remove(pet);
              } else {
                _selectedPets.add(pet);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSelected
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.white.withOpacity(0.53),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
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
                        '• Owner: ${pet.ownerEmail}',
                        style: TextStyle(
                          color: const Color(0xFF065591),
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 30,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
