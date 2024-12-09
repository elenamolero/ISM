import '../../../domain/entity/pet.entity.dart';
import '../pets_repository_interface.dart';

class PetRepositoryImpl implements PetsRepositoryInterface {
  @override
  Future<void> savePetInfo(Pet pet) async {
    //All related with the logic when saving data(API, database, etc...)
    print('Pet saved in repository: ${pet.name}');
  }

  @override
  Future<void> updatePetInfo(Pet pet) async {
    //All related with the logic when updating data(API, database, etc...)
    print('Pet updated in repository: ${pet.name}');
  }
}
