import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import '../../../domain/usecases/get_pets_by_owner_email.dart';
import '../../../domain/usecases/assign_vet_to_pet.dart';

// Events
abstract class AssignVetEvent {}

class FetchPetsByOwnerEmailEvent extends AssignVetEvent {
  final String ownerEmail;
  FetchPetsByOwnerEmailEvent(this.ownerEmail);
}

class AssignVetToPetEvent extends AssignVetEvent {
  final int petId;
  final String vetEmail;
  AssignVetToPetEvent(this.petId, this.vetEmail);
}

// States
abstract class AssignVetState {}

class AssignVetInitial extends AssignVetState {}

class AssignVetLoading extends AssignVetState {}

class PetsFetched extends AssignVetState {
  final List<Pet> pets;
  PetsFetched(this.pets);
}

class AssignVetSuccess extends AssignVetState {}

class AssignVetError extends AssignVetState {
  final String message;
  AssignVetError(this.message);
}

// BLoC
class AssignVetBloc extends Bloc<AssignVetEvent, AssignVetState> {
  final GetPetsByOwnerEmail getPetsByOwnerEmail;
  final AssignVetToPet assignVetToPet;

  AssignVetBloc({
    required this.getPetsByOwnerEmail,
    required this.assignVetToPet,
  }) : super(AssignVetInitial()) {
    on<FetchPetsByOwnerEmailEvent>((event, emit) async {
      emit(AssignVetLoading());
      try {
        final pets = await getPetsByOwnerEmail(event.ownerEmail);
        emit(PetsFetched(pets));
      } catch (e) {
        print('Error in AssignVetBloc while fetching pets: $e');
        emit(AssignVetError(e.toString()));
      }
    });

    on<AssignVetToPetEvent>((event, emit) async {
      emit(AssignVetLoading());
      try {
        await assignVetToPet(event.petId, event.vetEmail);
        emit(AssignVetSuccess());
      } catch (e) {
        print('Error in AssignVetBloc while assigning vet: $e');
        emit(AssignVetError(e.toString()));
      }
    });
  }
}
