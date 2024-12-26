import 'package:petuco/domain/entities/healthTest.dart';

abstract class GetHealthTestsUseCaseInterface {
  
  Future<List<HealthTest>> getHealthTests(int petId);
}
