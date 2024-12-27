import 'package:flutter/material.dart';
import 'package:petuco/data/repository/health_test_repository_interface.dart';
import 'package:petuco/data/services/healthTest/health_test_service.dart';
import 'package:petuco/domain/entities/healthTest.dart';


class HealthTestRepositoryImpl implements HealthTestRepositoryInterface {
  final HealthTestsService healthTestsService;

  HealthTestRepositoryImpl({required this.healthTestsService});

  @override
  Future<List<HealthTest>> getHealthTests(int petId) async {
    debugPrint('Fetching health tests in repository for petId: $petId');
    final healthTestResponses = await healthTestsService.fetchHealthTestsData(petId);
    debugPrint('Fetched healthTests in repository:');
    List<HealthTest> healthTests = healthTestResponses.map((healthTestResponse) {
      return HealthTest(
        testName: healthTestResponse.testName,
        description: healthTestResponse.description,
        date: healthTestResponse.date,
        vetId: healthTestResponse.vetId,
        petId: healthTestResponse.petId,
        place: healthTestResponse.place,
      );
    }).toList();
    for (var healthTest in healthTests) {
      debugPrint('healthTest: ${healthTest.testName}, ${healthTest.description}, ${healthTest.date}, ${healthTest.vetId}, ${healthTest.petId}, ${healthTest.place}');
    }  
    return healthTests;
  }

  @override
   Future<void> saveHealthTestInfo(HealthTest healthTest) async {
    try {
      await healthTestsService.saveHealthTestInfo(healthTest);
    } catch (e) {
      throw Exception('Failed to save healthTest info: $e');
    }
  }
}

