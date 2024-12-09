import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
import 'package:petuco/domain/usecases/get_pets_home_use_case_interface.dart';
class GetPetsHomeUseCase implements GetPetsHomeUseCaseInterface {
  PetRepositoryImpl petsRepository;
  GetPetsHomeUseCase({required this.petsRepository});
  @override
Future<List<Pet>> getPets() {
    return petsRepository.getPets();
  }
}