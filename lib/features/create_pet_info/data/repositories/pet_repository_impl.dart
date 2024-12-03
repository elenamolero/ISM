import '../../domain/entities/pet.dart';

abstract class PetRespository {
  Future<void> savePetInfo(Pet pet);
}

class PetRepositoryImpl implements PetRespository {
  @override
  Future<void> savePetInfo(Pet pet) async {
    //All related with the logic when saving data(API, database, etc...)
    print('Pet saved in repository: ${pet.name}');
  }
}
