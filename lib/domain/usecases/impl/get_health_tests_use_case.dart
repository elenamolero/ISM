import 'package:flutter/material.dart';
import 'package:petuco/data/repository/impl/health_test_repository_impl.dart';
import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/usecases/get_health_tests_use_case_interface.dart';
class GetHealthTestsUseCase implements GetHealthTestsUseCaseInterface {
  HealthTestRepositoryImpl healthTestsRepository;
  GetHealthTestsUseCase({required this.healthTestsRepository});
  @override
  Future<List<HealthTest>> getHealthTests(int petId) async {
    debugPrint('Fetching health tests for pet Id in use case: $petId');
    final healthTests = await healthTestsRepository.getHealthTests(petId);
    debugPrint('Fetched healthTests in use case:');
    for (var healthTest in healthTests) {
      debugPrint('healthTest:${healthTest.testName}, ${healthTest.description}, ${healthTest.date}, ${healthTest.vetId}, ${healthTest.petId}, ${healthTest.place}');
    }
    return healthTests;
  }
}