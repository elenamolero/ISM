import '../../../domain/entity/pet.entity.dart';

abstract class PetRespository {
  Future<void> savePetInfo(Pet pet);
}

class PetRepositoryImpl implements PetRespository {
  @override
  Future<void> savePetInfo(Pet pet) async {
    //All related with the logic when saving data(API, database, etc...)
    print('Pet saved in repository: ${pet.name}');
  }

  Future<void> updatePetInfo(Pet pet) async {
    //All related with the logic when updating data(API, database, etc...)
    print('Pet updated in repository: ${pet.name}');
  }
}
