import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
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
  final String _vetEmail = Supabase.instance.client.auth.currentUser!
      .email!; // Replace with actual authenticated vet email
  List<Pet> _selectedPets = [];

  @override
  void dispose() {
    _ownerEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Stack(
          children: [
            const BackGround(
              title: "Assign Pets",
              isUserLoggedIn: true,
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
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
                            TextField(
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
                            ),
                            const SizedBox(height: 20),
                            BlocConsumer<AssignVetBloc, AssignVetState>(
                              listener: (context, state) {
                                if (state is AssignVetSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Successfully assigned to pet(s)!')),
                                  );
                                  _selectedPets.clear();
                                } else if (state is AssignVetError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error: ${state.message}')),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: state is AssignVetLoading
                                          ? null
                                          : () {
                                              context.read<AssignVetBloc>().add(
                                                    FetchPetsByOwnerEmailEvent(
                                                        _ownerEmailController
                                                            .text),
                                                  );
                                            },
                                      child: state is AssignVetLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            )
                                          : const Text('Fetch Pets'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    if (state is PetsFetched)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: state.pets.length,
                                          itemBuilder: (context, index) {
                                            final pet = state.pets[index];
                                            return CheckboxListTile(
                                              title: Text(pet.name),
                                              subtitle: Text(
                                                  '${pet.breed}, ${pet.age} years old'),
                                              value:
                                                  _selectedPets.contains(pet),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (value == true) {
                                                    _selectedPets.add(pet);
                                                  } else {
                                                    _selectedPets.remove(pet);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    if (state is PetsFetched &&
                                        _selectedPets.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            for (var pet in _selectedPets) {
                                              context.read<AssignVetBloc>().add(
                                                    AssignVetToPetEvent(
                                                        pet.id, _vetEmail),
                                                  );
                                            }
                                          },
                                          child: const Text(
                                              'Assign Selected Pets'),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const FooterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
