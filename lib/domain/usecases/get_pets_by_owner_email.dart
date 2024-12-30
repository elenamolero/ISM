import 'package:petuco/domain/entities/pet.entity.dart';
import '../../data/repository/pets_repository_interface.dart';

class GetPetsByOwnerEmail {
  final PetsRepositoryInterface repository;

  GetPetsByOwnerEmail(this.repository);

  Future<List<Pet>> call(String ownerEmail) async {
    if (ownerEmail.isEmpty) {
      throw Exception('Owner email cannot be empty');
    }
    return await repository.getPetsByOwnerEmail(ownerEmail);
  }
}
