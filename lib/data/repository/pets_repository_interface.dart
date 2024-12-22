import 'dart:io';
import 'package:petuco/domain/entity/pet.entity.dart';

abstract class PetsRepositoryInterface {
  Future<void> savePetInfo(Pet pet, File? imageFile);
  Future<List<Pet>> getPets(String ownerEmail);
  Future<void> updatePetInfo(Pet pet, File? imageFile);
  Future<Pet> getPetById(int petId);
}
