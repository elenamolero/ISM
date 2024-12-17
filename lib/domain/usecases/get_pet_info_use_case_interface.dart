import 'package:petuco/domain/entity/pet.entity.dart';

abstract class GetPetInfoUseCaseInterface {
  
  Future<Pet> getPetById(int petId);
}