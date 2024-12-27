import 'package:petuco/domain/entities/healthTest.entity.dart';

abstract class GetHealthTestsUseCaseInterface {
  
  Future<List<HealthTest>> getHealthTests(int petId);
}
