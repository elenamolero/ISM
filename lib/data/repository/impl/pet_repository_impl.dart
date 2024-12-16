import 'package:flutter/material.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/data/services/model/pet_response.dart';
import 'package:petuco/data/services/pet/pets_service.dart';

import '../../../domain/entity/pet.entity.dart';

class PetRepositoryImpl implements PetsRepositoryInterface {
  final PetsService petsService;

  PetRepositoryImpl({required this.petsService});

  @override
  Future<void> savePetInfo(Pet pet) async {
    // Logic for saving pet information (API, database, etc.)
    print('Pet saved in repository: ${pet.name}');
  }

  Future<void> updatePetInfo(Pet pet) async {
    // Logic for updating pet information (API, database, etc.)
    print('Pet updated in repository: ${pet.name}');
  }

  @override
  Future<List<Pet>> getPets(String ownerEmail) async {
    debugPrint('Fetching pets in repository for owner: $ownerEmail');
    
    // Fetch the pet data from the service
    final petResponses = await petsService.fetchPetsData(ownerEmail);
    debugPrint('Fetched pets:');
    
    // Convert the list of PetResponse to Pet domain entities
    List<Pet> pets = petResponses.map((petResponse) {
      return Pet(
        name: petResponse.name,
        ownerEmail: petResponse.ownerEmail,
        age: petResponse.age,
        type: petResponse.type,
        breed: petResponse.breed,
        imageUrl: petResponse.imageUrl,
      );
    }).toList();
    
    // Debug print the converted pets list
    for (var pet in pets) {
      debugPrint('Pet: ${pet.name}, ${pet.ownerEmail}, ${pet.age}, ${pet.type}, ${pet.breed}, ${pet.imageUrl}');
    }
    
    return pets;
  }
}

