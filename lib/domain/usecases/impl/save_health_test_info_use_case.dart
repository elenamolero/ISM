import 'package:flutter/material.dart';
import 'package:petuco/data/repository/impl/health_test_repository_impl.dart';
import 'package:petuco/domain/entities/healthTest.entity.dart';
import 'package:petuco/domain/usecases/save_health_test_use_case_interface.dart';

class SaveHealthTestInfoUseCase extends SaveHealthTestInfoUseCaseInterface {

  HealthTestRepositoryImpl healthTestRepository;

  SaveHealthTestInfoUseCase({required this.healthTestRepository});
  
  @override
  Future<void> saveHealthTestInfo(HealthTest healthTest) async {
    debugPrint("Saving health test: ${healthTest.toString()}");
    await healthTestRepository.saveHealthTestInfo(healthTest);
  }
  
}