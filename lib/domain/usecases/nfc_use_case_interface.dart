import 'package:petuco/domain/entities/pet.entity.dart' as pet;

abstract class NFCUseCaseInterface {
  Future<void> nfcInfo(pet.Pet pet);
}