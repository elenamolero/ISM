import 'package:petuco/domain/entity/pet.entity.dart';

abstract class PetsRepositoryInterface {
  Future<void> savePetInfo(Pet pet);

  Future<void> updatePetInfo(Pet pet);
}
