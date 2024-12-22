import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/entities/pet.dart';
import 'package:petuco/domain/usecases/get_health_tests_use_case_interface.dart';
import 'package:petuco/domain/usecases/get_pets_home_use_case_interface.dart';

// Estados
abstract class HealthTestState {}

class HealthTestInitial extends HealthTestState {}

class HealthTestLoading extends HealthTestState {}

class HealthTestLoaded extends HealthTestState {
  final List<HealthTest> healthTests;

  HealthTestLoaded({required this.healthTests});
}

class HealthTestError extends HealthTestState {
  final String message;

  HealthTestError(this.message);
}

// Eventos
abstract class HealthTestEvent {}

class FetchHealthTests extends HealthTestEvent {
  final int petId;

  FetchHealthTests({required this.petId});
}

// BLoC
class HealthTestBloc extends Bloc<HealthTestEvent, HealthTestState> {
  final GetHealthTestsUseCaseInterface getHealthTestsUseCase;

  HealthTestBloc({required this.getHealthTestsUseCase}) : super(HealthTestInitial()) {
    on<FetchHealthTests>(_fetchHealthTests);
  }

  Future<void> _fetchHealthTests(FetchHealthTests event, Emitter<HealthTestState> emit) async {
    emit(HealthTestLoading());
    try {
      final healthTests = await getHealthTestsUseCase.getHealthTests(event.petId);
      emit(HealthTestLoaded(healthTests: healthTests));
    } catch (error) {
      emit(HealthTestError("Failed to load HealthTests: ${error.toString()}"));
    }
  }
}
