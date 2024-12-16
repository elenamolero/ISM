import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/entity/pet.entity.dart';

abstract class GetHealthTestsUseCaseInterface {
  
  Future<List<HealthTest>> getHealthTests(int petId);
}
