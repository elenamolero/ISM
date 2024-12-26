import '../entity/pet.entity.dart';
import '../../data/repository/pets_repository_interface.dart';
import 'dart:io';

class UpdatePetInfo {
  final PetsRepositoryInterface repository;

  UpdatePetInfo(this.repository);

  Future<void> call(Pet pet, File? imageFile) async {
    //All business rules has to be here (validations, rules...)
    if (pet.name.isEmpty) {
      throw Exception('Pet name cannot be empty');
    }
    if (pet.age < 0) {
      throw Exception('Pet age cannot be negative');
    }
    await repository.updatePetInfo(pet, imageFile);
  }
}
