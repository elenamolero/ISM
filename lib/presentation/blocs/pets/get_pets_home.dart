import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
import 'package:petuco/domain/usecases/get_pets_home_use_case_interface.dart';

// Estados
abstract class PetState {}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<Pet> pets;

  PetLoaded({required this.pets});
}

class PetError extends PetState {
  final String message;

  PetError(this.message);
}

// Eventos
abstract class PetEvent {}

class FetchPets extends PetEvent {
  final String ownerEmail;

  FetchPets({required this.ownerEmail});
}

// BLoC
class PetBloc extends Bloc<PetEvent, PetState> {
  final GetPetsHomeUseCaseInterface getPetsUseCase;

  PetBloc({required this.getPetsUseCase}) : super(PetInitial()) {
    on<FetchPets>(_fetchPets);
  }

  Future<void> _fetchPets(FetchPets event, Emitter<PetState> emit) async {
    emit(PetLoading());
    try {
      final pets = await getPetsUseCase.getPets(event.ownerEmail);
      emit(PetLoaded(pets: pets));
    } catch (error) {
      emit(PetError("Failed to load pets: ${error.toString()}"));
    }
  }
}
