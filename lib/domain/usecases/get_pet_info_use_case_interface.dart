import 'package:petuco/domain/entities/pet.entity.dart';

abstract class GetPetInfoUseCaseInterface {
  
  Future<Pet> getPetById(int petId);
}