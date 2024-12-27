
import 'package:petuco/domain/entities/healthTest.entity.dart' as healthTest;

abstract class SaveHealthTestInfoUseCaseInterface {
  Future<void> saveHealthTestInfo(healthTest.HealthTest healthTest);
}