import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/pet.entity.dart';
import '../../../domain/usecases/save_pet_info.dart';

//Events
abstract class UpdatePetInfoEvent {}

class SavePetEvent extends UpdatePetInfoEvent {
  final Pet pet;
  SavePetEvent(this.pet);
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
  final SavePetInfo savePetInfo;

  UpdatePetInfoBloc(this.savePetInfo) : super(UpdatePetInitial()) {
    on<SavePetEvent>((event, emit) async {
      emit(UpdatePetLoading());
      try {
        await savePetInfo(event.pet);
        emit(UpdatePetSuccess());
      } catch (e) {
        emit(UpdatePetError("Failed to update pet info") as UpdatePetInfoState);
      }
    });
  }
}
