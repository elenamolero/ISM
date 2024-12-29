import 'dart:io';
import 'package:petuco/domain/usecases/save_pet_info_use_case_interface.dart';

import '../../entities/pet.entity.dart';
import '../../../data/repository/pets_repository_interface.dart';

class SavePetInfoUseCase implements SavePetInfoUseCaseInterface {

  final PetsRepositoryInterface repository;

  SavePetInfoUseCase({required this.repository});
  @override
  Future<void> savePetInfo(Pet pet, File? imageFile) async {
    if (pet.name.isEmpty) {
      throw Exception('Pet name cannot be empty');
    }
    if (pet.age < 0) {
      throw Exception('Pet age cannot be negative');
    }
    await repository.savePetInfo(pet, imageFile);
  }
}
