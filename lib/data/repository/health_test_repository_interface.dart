import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/entities/pet.dart';

abstract class HealthTestRepositoryInterface {
  Future<List<HealthTest>> getHealthTests(int petId);
}
