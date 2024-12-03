import '../entities/pet.dart';

class SavePetInfo {
  Future<void> call(Pet pet) async {
    //All business rules has to be here (validations, rules...)
    print(
        'Pet info saved correctly: ${pet.name}, ${pet.ownerID}, ${pet.age}, ${pet.type}, ${pet.breed}');
  }
}
