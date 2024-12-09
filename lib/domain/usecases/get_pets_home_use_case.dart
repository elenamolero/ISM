import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entity/pet.entity.dart';

class GetPetsHomeUseCase {
  PetsRepositoryInterface petsRepository;
  GetPetsHomeUseCase({required this.petsRepository});
  @override
  Future<List<Pet>> getPets() {
    return petsRepository.getPets();
  }
}

