import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/data/services/model/pet_response.dart';
import 'package:petuco/data/services/pet/pets_service.dart';

import '../../../domain/entities/pet.entity.dart';

class PetRepositoryImpl implements PetsRepositoryInterface {
  final PetsService petsService;

  PetRepositoryImpl({required this.petsService});

  @override
  Future<void> savePetInfo(Pet pet, File? imageFile) async {
    try {
      String? photo;
      if (imageFile != null) {
        photo = await petsService.uploadImage(imageFile);
      }

      final petResponse = PetResponse(
        id: pet.id,
        name: pet.name,
        ownerEmail: pet.ownerEmail,
        sex: pet.sex,
        age: pet.age,
        type: pet.type,
        breed: pet.breed,
        photo: photo,
        nfcConnection: false,
      );
      await petsService.savePetData(petResponse);
    } catch (e) {
      print('Error in repository while saving pet info: $e');
      throw Exception('Failed to save pet info: $e');
    }
  }

  @override
  Future<void> updatePetInfo(Pet pet, File? imageFile) async {
    try {
      String? imageUrl = pet.photo;
      if (imageFile != null) {
        debugPrint('Uploading new image...');
        imageUrl = await petsService.uploadImage(imageFile);
      }

      final petResponse = PetResponse(
        id: pet.id,
        name: pet.name,
        ownerEmail: pet.ownerEmail,
        sex: pet.sex,
        age: pet.age,
        type: pet.type,
        breed: pet.breed,
        photo: imageUrl,
        nfcConnection: pet.nfcConnection,
      );

      debugPrint('Updating pet data: ${petResponse.toMap()}');
      await petsService.updatePetData(petResponse);
      debugPrint('Pet data updated successfully');
    } catch (e) {
      debugPrint('Error in repository while updating pet info: $e');
      throw Exception('Failed to update pet info: $e');
    }
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
        id: petResponse.id,
        name: petResponse.name,
        ownerEmail: petResponse.ownerEmail,
        sex: petResponse.sex,
        age: petResponse.age,
        type: petResponse.type,
        breed: petResponse.breed,
        photo: petResponse.photo,
        nfcConnection: petResponse.nfcConnection,
      );
    }).toList();

    // Debug print the converted pets list
    for (var pet in pets) {
      debugPrint(
          'Pet: ${pet.name}, ${pet.ownerEmail}, ${pet.age}, ${pet.type}, ${pet.breed}, ${pet.photo}');
    }

    return pets;
  }

  @override
  Future<Pet> getPetById(int petId) async {
    debugPrint('Fetching pet in repository for id: $petId');

    // Fetch the pet data from the service
    final petResponse = await petsService.fetchPetDataById(petId);

    
    if (petResponse != null) {
      debugPrint('Fetched pet data: $petResponse');

      
      final pet = Pet(
        id: petResponse.id,
        name: petResponse.name,
        ownerEmail: petResponse.ownerEmail,
        sex: petResponse.sex,
        age: petResponse.age,
        type: petResponse.type,
        breed: petResponse.breed,
        photo: petResponse.photo,
        nfcConnection: petResponse.nfcConnection,
      );

      debugPrint(
          'Pet: ${pet.name}, ${pet.ownerEmail}, ${pet.age}, ${pet.type}, ${pet.breed}, ${pet.photo}');
      return pet;
    } else {
      throw Exception('Pet not found for id $petId');
    }
  }

  Future<bool> nfcInfo(Pet pet) async {
    
    try {
      await petsService.nfcInfo(pet);
      return true;
    } catch (error) {
      debugPrint('Error updating pet data: $error');
      return false;
    }
  }
}
