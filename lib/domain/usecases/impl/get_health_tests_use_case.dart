import 'package:flutter/material.dart';
import 'package:petuco/data/repository/health_test_repository_interface.dart';
import 'package:petuco/domain/entities/healthTest.entity.dart';
import 'package:petuco/domain/usecases/get_health_tests_use_case_interface.dart';
class GetHealthTestsUseCase implements GetHealthTestsUseCaseInterface {
  HealthTestRepositoryInterface healthTestRepositoryInterface;
  GetHealthTestsUseCase({required this.healthTestRepositoryInterface});
  @override
  Future<List<HealthTest>> getHealthTests(int petId) async {
    debugPrint('Fetching health tests for pet Id in use case: $petId');
    final healthTests = await healthTestRepositoryInterface.getHealthTests(petId);
    debugPrint('Fetched healthTests in use case:');
    for (var healthTest in healthTests) {
      debugPrint('healthTest:${healthTest.testName}, ${healthTest.description}, ${healthTest.date}, ${healthTest.vetId}, ${healthTest.petId}, ${healthTest.place}');
    }
    return healthTests;
  }
}