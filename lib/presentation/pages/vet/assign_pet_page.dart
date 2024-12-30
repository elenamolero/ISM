import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:petuco/presentation/blocs/pets/assign_vet_bloc.dart';
import 'package:petuco/domain/usecases/assign_vet_to_pet.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AsignPetPage extends StatefulWidget {
  @override
  _AsignPetPageState createState() => _AsignPetPageState();
}

class _AsignPetPageState extends State<AsignPetPage> {
  final TextEditingController _petIdController = TextEditingController();
  final String _vetEmail = Supabase.instance.client.auth.currentUser!.email!;

  @override
  void dispose() {
    _petIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignVetBloc(
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
              title: "Assign a pet",
              isUserLoggedIn: true,
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Assign yourself to a new patient",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: const String.fromEnvironment("Inter"),
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 175,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  TextField(
                    controller: _petIdController,
                    decoration: InputDecoration(
                      hintText: 'Enter the ID of the pet',
                      suffixIcon: const Icon(Icons.pets),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AssignVetBloc, AssignVetState>(
                    listener: (context, state) {
                      if (state is AssignVetSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Successfully assigned to pet!')),
                        );
                      } else if (state is AssignVetError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${state.message}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is AssignVetLoading
                            ? null
                            : () {
                                final petId =
                                    int.tryParse(_petIdController.text);
                                if (petId != null) {
                                  context.read<AssignVetBloc>().add(
                                        AssignVetToPetEvent(petId, _vetEmail),
                                      );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please enter a valid pet ID')),
                                  );
                                }
                              },
                        child: state is AssignVetLoading
                            ? const CircularProgressIndicator()
                            : const Text('Assign to Pet'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                      );
                    },
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
}
