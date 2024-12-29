import 'package:flutter/material.dart';
import 'package:petuco/data/repository/health_test_repository_interface.dart';
import 'package:petuco/domain/entities/healthTest.entity.dart';
import 'package:petuco/domain/usecases/save_health_test_use_case_interface.dart';

class SaveHealthTestInfoUseCase extends SaveHealthTestInfoUseCaseInterface {

  HealthTestRepositoryInterface healthTestRepositoryInterface;

  SaveHealthTestInfoUseCase({required this.healthTestRepositoryInterface});
  
  @override
  Future<void> saveHealthTestInfo(HealthTest healthTest) async {
    debugPrint("Saving health test: ${healthTest.toString()}");
    await healthTestRepositoryInterface.saveHealthTestInfo(healthTest);
  }
  
}