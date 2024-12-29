import 'package:petuco/domain/usecases/update_pet_info_use_case_interface.dart';

import '../../entities/pet.entity.dart';
import '../../../data/repository/pets_repository_interface.dart';
import 'dart:io';

class UpdatePetInfoUseCase implements UpdatePetInfoUseCaseInterface {

  final PetsRepositoryInterface repository;

  UpdatePetInfoUseCase({required this.repository});

  @override
  Future<void> updatePetInfo(Pet pet, File? imageFile) async {
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
