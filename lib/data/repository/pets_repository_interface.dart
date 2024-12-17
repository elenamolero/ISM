import 'package:petuco/domain/entity/pet.entity.dart';

abstract class PetsRepositoryInterface {
  Future<void> savePetInfo(Pet pet);
  Future<List<Pet>> getPets(String ownerEmail);
  Future<void> updatePetInfo(Pet pet);
  Future<Pet> getPetById(int petId);
}
