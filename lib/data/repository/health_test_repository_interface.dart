import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/entity/pet.entity.dart';

abstract class HealthTestRepositoryInterface {
  Future<List<HealthTest>> getHealthTests(int petId);
}
