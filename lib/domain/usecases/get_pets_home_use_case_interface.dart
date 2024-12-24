import 'package:petuco/domain/entity/pet.entity.dart';

abstract class GetPetsHomeUseCaseInterface {
  
  Future<List<Pet>> getPets(String ownerEmail);
}

