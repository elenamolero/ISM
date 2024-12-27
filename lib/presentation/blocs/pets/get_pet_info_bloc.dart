import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import 'package:petuco/domain/usecases/get_pet_info_use_case_interface.dart';

// Estados
abstract class PetState {}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final Pet pet;

  PetLoaded({required this.pet});
}

class PetError extends PetState {
  final String message;

  PetError(this.message);
}

// Eventos
abstract class PetEvent {}

class FetchPet extends PetEvent {
  final int petId;

  FetchPet({required this.petId});
}

// BLoC
class PetBloc extends Bloc<PetEvent, PetState> {
  final GetPetInfoUseCaseInterface getPetUseCase;

  PetBloc({required this.getPetUseCase}) : super(PetInitial()) {
    on<FetchPet>(_fetchPet);
  }

  Future<void> _fetchPet(FetchPet event, Emitter<PetState> emit) async {
    emit(PetLoading());
    try {
      final pet = await getPetUseCase.getPetById(event.petId);
      emit(PetLoaded(pet: pet));
    } catch (error) {
      emit(PetError("Failed to load pet: ${error.toString()}"));
    }
  }
}
