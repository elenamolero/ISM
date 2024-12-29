import 'package:flutter/material.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import 'package:petuco/domain/usecases/get_pet_info_use_case_interface.dart';

class GetPetInfoUseCase implements GetPetInfoUseCaseInterface {
  PetsRepositoryInterface petRepositoryInterface;

  GetPetInfoUseCase({required this.petRepositoryInterface});

  @override
  Future<Pet> getPetById(int petId) async {
    debugPrint('Fetching pet in use case for id: $petId');

    final pet = await petRepositoryInterface.getPetById(petId);
    debugPrint('Fetched pet:');

    debugPrint(
        'Pet: ${pet.name}, ${pet.ownerEmail}, ${pet.age}, ${pet.type}, ${pet.breed}, ${pet.photo}');
    return pet;
  }
}
