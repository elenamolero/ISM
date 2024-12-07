import 'package:petuco/features/home/data/repositories/pets_repository_interface.dart';
import 'package:petuco/features/home/domain/entities/pet.dart';
import 'package:petuco/features/home/domain/usecases/get_pets_home_use_case_interface.dart';

class GetPetsHomeUseCase extends GetPetsUseCaseInterface{
  PetsRepositoryInterface petsRepository;
  GetPetsHomeUseCase({required this.petsRepository});
  @override
  Future<List<Pet>> getPets() {
    return petsRepository.getPets();
  }
}

