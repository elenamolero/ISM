import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/assign_vet_to_pet.dart';

// Events
abstract class AssignVetEvent {}

class AssignVetToPetEvent extends AssignVetEvent {
  final int petId;
  final String vetEmail;
  AssignVetToPetEvent(this.petId, this.vetEmail);
}

// States
abstract class AssignVetState {}

class AssignVetInitial extends AssignVetState {}

class AssignVetLoading extends AssignVetState {}

class AssignVetSuccess extends AssignVetState {}

class AssignVetError extends AssignVetState {
  final String message;
  AssignVetError(this.message);
}

// BLoC
class AssignVetBloc extends Bloc<AssignVetEvent, AssignVetState> {
  final AssignVetToPet assignVetToPet;

  AssignVetBloc({required this.assignVetToPet}) : super(AssignVetInitial()) {
    on<AssignVetToPetEvent>((event, emit) async {
      emit(AssignVetLoading());
      try {
        await assignVetToPet(event.petId, event.vetEmail);
        emit(AssignVetSuccess());
      } catch (e) {
        print('Error in AssignVetBloc: $e');
        emit(AssignVetError(e.toString()));
      }
    });
  }
}
