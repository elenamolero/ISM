import 'package:petuco/domain/entities/pet.dart';

abstract class GetPetsHomeUseCaseInterface {
  
  Future<List<Pet>> getPets(String ownerEmail);
}

