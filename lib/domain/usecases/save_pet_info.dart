import '../entity/pet.entity.dart';

class SavePetInfo {
  Future<void> call(Pet pet) async {
    //All business rules has to be here (validations, rules...)
    print(
        'Pet info saved correctly: ${pet.name}, ${pet.ownerEmail}, ${pet.age}, ${pet.type}, ${pet.breed}');
  }
}
