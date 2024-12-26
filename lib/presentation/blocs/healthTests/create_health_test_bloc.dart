import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/usecases/save_health_test_use_case_interface.dart';


//Events

abstract class CreateHealthTestInfoEvent {}

class CreateHealthTestEvent extends CreateHealthTestInfoEvent {
  final HealthTest healthTest;
  CreateHealthTestEvent(this.healthTest);
}

//States

abstract class CreateHealthTestInfoState {}

class CreateHealthTestInitial extends CreateHealthTestInfoState {}
class CreateHealthTestLoading extends CreateHealthTestInfoState {}
class CreateHealthTestSuccess extends CreateHealthTestInfoState {}
class CreateHealthTestError extends CreateHealthTestInfoState {
  final String message;
  CreateHealthTestError(this.message);
}

// BLoC
class CreateHealthTestInfoBloc extends Bloc<CreateHealthTestEvent, CreateHealthTestInfoState> {
  SaveHealthTestInfoUseCaseInterface createHealthTestUseCase;

  CreateHealthTestInfoBloc({required this.createHealthTestUseCase}) : super(CreateHealthTestInitial()) {
    on<CreateHealthTestEvent>((event, emit) async {
      emit(CreateHealthTestLoading());
      try {
        debugPrint("Saving health test...");
        await createHealthTestUseCase.saveHealthTestInfo(event.healthTest);
        debugPrint("Health test saved successfully.");
        emit(CreateHealthTestSuccess());
      } catch (e) {
        emit(CreateHealthTestError("Failed to save new healthTest info") as CreateHealthTestInfoState);
      }
    });
  }
}