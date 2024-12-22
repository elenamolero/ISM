import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entities/pet.dart';

abstract class GetPetsHomeUseCaseInterface {
  
  Future<List<Pet>> getPets(String ownerEmail);
}

