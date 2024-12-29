import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import 'package:petuco/domain/usecases/impl/get_pet_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/update_pet_info_use_case.dart';
import 'package:petuco/presentation/blocs/pets/update_pet_info_bloc.dart';
import 'package:petuco/presentation/pages/common/pet_info_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NfcConnectionView extends StatefulWidget {
  final int petId;
  const NfcConnectionView({super.key, required this.petId});

  @override
  State<NfcConnectionView> createState() => _NfcConnectionViewState();
}

class _NfcConnectionViewState extends State<NfcConnectionView> {
  final _nameController = TextEditingController();
  final _ownerController = TextEditingController();
  final _sexController = TextEditingController();
  final _ageController = TextEditingController();
  final _typeController = TextEditingController();
  final _breedController = TextEditingController();
  File? _imageFile;
  String? _currentImageUrl;
  bool _isFieldsPopulated = false;
  bool isNfcConnected = false; // Track the NFC connection state
  bool isWritingInProgress = false; // Track if NFC writing is in progress

  @override
  void dispose() {
    _nameController.dispose();
    _ownerController.dispose();
    _sexController.dispose();
    _ageController.dispose();
    _typeController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  void _populateFields(Pet pet) {
    _nameController.text = pet.name;
    _ownerController.text = pet.ownerEmail;
    _sexController.text = pet.sex;
    _ageController.text = pet.age.toString();
    _typeController.text = pet.type;
    _breedController.text = pet.breed;
    _currentImageUrl = pet.photo;
    isNfcConnected = pet.nfcConnection!; // Set the NFC connection state
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String role = Supabase.instance.client.auth.currentUser?.userMetadata!['role'] as String;

    return BlocProvider(
      create: (_) => UpdatePetInfoBloc(
          updatePetInfo: appInjector.get<UpdatePetInfoUseCase>(),
          getPetInfoUseCase: appInjector.get<GetPetInfoUseCase>(),
      )..add(LoadPetEvent(widget.petId)),
      child: Scaffold(
        body: Stack(
          children: [
            const BackGround(title: "NFC connection",isUserLoggedIn: true,),
            BlocConsumer<UpdatePetInfoBloc, UpdatePetInfoState>(
              listener: (context, state) {
                if (state is UpdatePetSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pet info updated successfully!'),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is UpdatePetError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is PetLoaded && !_isFieldsPopulated) {
                  _populateFields(state.pet);
                  _isFieldsPopulated = true;
                }
                return Stack(
                  children: [
                    Positioned(
                      top: screenHeight * 0.15,
                      left: 0,
                      right: 0,
                      child: Text(
                        "Save your pet’s data in\nits NFC",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: const String.fromEnvironment("Inter"),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.45,
                      left: (screenWidth - screenWidth * 0.8) / 2,
                      child: Image.asset(
                      isNfcConnected
                        ? 'assets/images/nfcConnected.png' // Imagen cuando NFC está conectado
                        : 'assets/images/nfcConection.png', // Imagen cuando NFC no está conectado
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.3,
                      fit: BoxFit.contain,
                    ),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.40,
                      left: 0,
                      right: 0,
                      child: const Text(
                        "Current connection",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: String.fromEnvironment("Inter"),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.28,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1,
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.07),
                        decoration: BoxDecoration(
                          color: isNfcConnected
                              ? Colors.green.withOpacity(0.7)
                              : Colors.white.withOpacity(0.53),
                          borderRadius: BorderRadius.circular(40),
                          border: isNfcConnected
                              ? Border.all(
                                  color: Colors.green,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Text(
                          isNfcConnected ? "NFC Connected" : "No NFC connection",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            color: isNfcConnected ? Colors.white : const Color(0xFF4B8CAF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.15,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1,
                      child: Opacity(
                        opacity: 0.9,
                        child: ElevatedButton(
                          onPressed: !isWritingInProgress && !isNfcConnected
                              ? () async {
                                  setState(() {
                                    isWritingInProgress = true;
                                  });

                                  await NfcManager.instance.startSession(
                                    onDiscovered: (NfcTag tag) async {
                                      final ndef = Ndef.from(tag);
                                      String petId = widget.petId.toString();
                                      final url = 'https://bucolic-fox-5c474a.netlify.app/infopet/$petId';
                                      if (ndef != null) {
                                        try {
                                          if (isWritingInProgress) {
                                            

                                            // Write in the NFC tag
                                            NdefMessage message = NdefMessage([
                                              NdefRecord.createUri(Uri.parse(url)),
                                            ]);
                                            await ndef.write(message);
                                            debugPrint("URL escrita en NFC: $url");
                                            if (mounted) {
                                              context.read<UpdatePetInfoBloc>().add(
                                                UpdatePetEvent(
                                                  Pet(
                                                    id: widget.petId,
                                                    name: _nameController.text,
                                                    ownerEmail: _ownerController.text,
                                                    sex: _sexController.text,
                                                    age: int.parse(_ageController.text),
                                                    type: _typeController.text,
                                                    breed: _breedController.text,
                                                    photo: _currentImageUrl,
                                                    nfcConnection: true,
                                                  ),
                                                  _imageFile,
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data written to NFC')));
                                              Navigator.pop(context); // Volver a la pantalla anterior
                                            }
                                          } else {
                                            // Read from the NFC tag
                                            NdefMessage message = await ndef.read();
                                            String nfcData = message.records.first.payload.toString();

                                            // get id from payload
                                            String petIdString = nfcData.trim();
                                            int petId = int.parse(petIdString);
                                            setState(() {
                                              isNfcConnected = true;
                                              isWritingInProgress = false;
                                            });
                                            if (mounted) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => PetInfoPage(petId: petId, userRole: role),
                                                ),
                                              );
                                            }
                                          }
                                        } catch (e) {
                                          debugPrint("Error reading or writing NFC data: $e");
                                          setState(() {
                                            isWritingInProgress = false;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          isWritingInProgress = false;
                                        });
                                      }
                                    },
                                  );
                                }
                              : null, // Disable if NFC is connected or writing is in progress
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF65D389),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.12, vertical: screenHeight * 0.03),
                          ),
                          child: Text(
                            isWritingInProgress ? 'Writing...' : 'Look for a NFC',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}