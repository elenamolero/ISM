import '../entity/pet.entity.dart';

class UpdatePetInfo {
  Future<void> call(Pet pet) async {
    //All business rules has to be here (validations, rules...)
    print(
        'Pet info updated correctly: ${pet.name}, ${pet.ownerEmail}, ${pet.age}, ${pet.type}, ${pet.breed}');
  }
}
