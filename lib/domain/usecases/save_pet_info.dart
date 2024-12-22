import '../entity/pet.entity.dart';
import '../../data/repository/pets_repository_interface.dart';

class SavePetInfo {
  final PetsRepositoryInterface repository;

  SavePetInfo(this.repository);

  Future<void> call(Pet pet) async {
    // Add any business logic or validation here
    if (pet.age < 0) {
      throw Exception('Pet age cannot be negative');
    }
    await repository.savePetInfo(pet);
  }
}
