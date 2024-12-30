import 'dart:io';
import 'package:petuco/domain/entities/pet.entity.dart';

abstract class PetsRepositoryInterface {
  Future<void> savePetInfo(Pet pet, File? imageFile);
  Future<List<Pet>> getPets(String ownerEmail, String role);
  Future<void> updatePetInfo(Pet pet, File? imageFile);
  Future<Pet> getPetById(int petId);
  Future<void> assignVetToPet(int petId, String vetEmail);
  Future<List<Pet>> getPetsByOwnerEmail(String vetEmail);
}
