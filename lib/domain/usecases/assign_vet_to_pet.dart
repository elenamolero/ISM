import 'package:petuco/data/repository/pets_repository_interface.dart';

class AssignVetToPet {
  final PetsRepositoryInterface repository;

  AssignVetToPet(this.repository);

  Future<void> call(int petId, String vetEmail) async {
    if (petId <= 0) {
      throw Exception('Invalid pet ID');
    }
    if (vetEmail.isEmpty) {
      throw Exception('Vet email cannot be empty');
    }
    await repository.assignVetToPet(petId, vetEmail);
  }
}
