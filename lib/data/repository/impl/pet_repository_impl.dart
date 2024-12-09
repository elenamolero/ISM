import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/data/service/pets_service.dart';

import '../../../domain/entity/pet.entity.dart';



class PetRepositoryImpl implements PetsRepositoryInterface {
  PetsService petsService = PetsService();
  PetRepositoryImpl({required this.petsService});
  @override
  Future<void> savePetInfo(Pet pet) async {
    //All related with the logic when saving data(API, database, etc...)
    print('Pet saved in repository: ${pet.name}');
  }

  Future<void> updatePetInfo(Pet pet) async {
    //All related with the logic when updating data(API, database, etc...)
    print('Pet updated in repository: ${pet.name}');
  }

  @override
  Future<List<Pet>> getPets() {
    return petsService.fetchPetsData();
  }
}
