import 'package:flutter/material.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
import 'package:petuco/domain/usecases/get_pet_info_use_case_interface.dart';

class GetPetInfoUseCase implements GetPetInfoUseCaseInterface {
  PetRepositoryImpl petRepository;

  GetPetInfoUseCase({required this.petRepository});

  @override
  Future<Pet> getPetById(int petId) async {
    debugPrint('Fetching pet in use case for id: $petId');
    
    final pet = await petRepository.getPetById(petId);
    debugPrint('Fetched pet:');
    
    debugPrint('Pet: ${pet.name}, ${pet.ownerEmail}, ${pet.age}, ${pet.type}, ${pet.breed}, ${pet.imageUrl}');
    return pet;
  }
}