import 'package:petuco/domain/entities/pet.entity.dart';

abstract class GetPetsHomeUseCaseInterface {
  
  Future<List<Pet>> getPets(String ownerEmail);
}

