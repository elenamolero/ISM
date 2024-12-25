import 'package:flutter/material.dart';
import 'package:petuco/data/repository/health_test_repository_interface.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/data/services/healthTest/health_test_service.dart';
import 'package:petuco/data/services/model/health_test_response.dart';
import 'package:petuco/data/services/model/pet_response.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:petuco/domain/entities/healthTest.dart';

import '../../../domain/entity/pet.entity.dart';

class HealthTestRepositoryImpl implements HealthTestRepositoryInterface {
  final HealthTestsService healthTestsService;

  HealthTestRepositoryImpl({required this.healthTestsService});

  @override
  Future<List<HealthTest>> getHealthTests(int petId) async {
    debugPrint('Fetching health tests in repository for petId: $petId');
    
    // Fetch the pet data from the service
    final healthTestResponses = await healthTestsService.fetchHealthTestsData(petId);
    debugPrint('Fetched healthTests in repository:');
    
    // Convert the list of PetResponse to Pet domain entities
    List<HealthTest> healthTests = healthTestResponses.map((healthTestResponse) {
      return HealthTest(
        id: healthTestResponse.id,
        testName: healthTestResponse.testName,
        description: healthTestResponse.description,
        date: healthTestResponse.date,
        vetId: healthTestResponse.vetId,
        petId: healthTestResponse.petId,
        place: healthTestResponse.place,
      );
    }).toList();
    
    // Debug print the converted pets list
    for (var healthTest in healthTests) {
      debugPrint('healthTest: ${healthTest.id}, ${healthTest.testName}, ${healthTest.description}, ${healthTest.date}, ${healthTest.vetId}, ${healthTest.petId}, ${healthTest.place}');
    }
    
    return healthTests;
  }
}

