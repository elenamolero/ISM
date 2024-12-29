import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import 'package:petuco/domain/usecases/nfc_use_case_interface.dart';

class NFCUseCase extends NFCUseCaseInterface {

  PetsRepositoryInterface petRepositoryInterface;

  NFCUseCase({required this.petRepositoryInterface});
  
  @override
  Future<void> nfcInfo(Pet pet) async {
    try {
      await petRepositoryInterface.nfcInfo(pet);
    } catch (e) {
      rethrow; 
    }
  }
}