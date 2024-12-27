import 'package:petuco/domain/entities/healthTest.entity.dart';

abstract class HealthTestRepositoryInterface {
  Future<List<HealthTest>> getHealthTests(int petId);
  Future<void> saveHealthTestInfo(HealthTest healthTest);
}
