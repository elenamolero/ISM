import 'package:petuco/domain/entities/pet.dart';

abstract class GetPetInfoUseCaseInterface {
  
  Future<Pet> getPetById(int petId);
}