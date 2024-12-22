import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/pet.dart';
import '../../../domain/usecases/update_pet_info.dart';

//Events
abstract class UpdatePetInfoEvent {}

class UpdatePetEvent extends UpdatePetInfoEvent {
  final Pet pet;
  UpdatePetEvent(this.pet);
}

//States
abstract class UpdatePetInfoState {}

class UpdatePetInitial extends UpdatePetInfoState {}

class UpdatePetLoading extends UpdatePetInfoState {}

class UpdatePetSuccess extends UpdatePetInfoState {}

class UpdatePetError extends UpdatePetInfoState {
  final String message;
  UpdatePetError(this.message);
}

// BLoC
class UpdatePetInfoBloc extends Bloc<UpdatePetInfoEvent, UpdatePetInfoState> {
  final UpdatePetInfo updatePetInfo;

  UpdatePetInfoBloc(this.updatePetInfo) : super(UpdatePetInitial()) {
    on<UpdatePetEvent>((event, emit) async {
      emit(UpdatePetLoading());
      try {
        await updatePetInfo(event.pet);
        emit(UpdatePetSuccess());
      } catch (e) {
        emit(UpdatePetError("Failed to update pet info") as UpdatePetInfoState);
      }
    });
  }
}
