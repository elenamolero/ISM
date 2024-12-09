import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entity/pet.entity.dart';

abstract class GetPetsHomeUseCaseInterface {
  
  Future<List<Pet>> getPets();
}

