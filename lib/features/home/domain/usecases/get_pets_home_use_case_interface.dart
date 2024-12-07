import '../entities/pet.dart';

abstract class GetPetsUseCaseInterface {

  Future<List<Pet>> getPets();
}