import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/entities/pet.dart';

abstract class GetHealthTestsUseCaseInterface {
  
  Future<List<HealthTest>> getHealthTests(int petId);
}
