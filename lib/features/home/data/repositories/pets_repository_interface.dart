import 'package:petuco/features/home/domain/entities/pet.dart';

abstract class PetsRepositoryInterface {
  Future<List<Pet>> getPets();
}