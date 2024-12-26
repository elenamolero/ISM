
import 'package:petuco/domain/entities/healthTest.dart' as healthTest;

abstract class SaveHealthTestInfoUseCaseInterface {
  Future<void> saveHealthTestInfo(healthTest.HealthTest healthTest);
}