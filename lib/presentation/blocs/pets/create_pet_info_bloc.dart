import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/pet.entity.dart';
import '../../../domain/usecases/save_pet_info.dart';

// Events
abstract class CreatePetInfoEvent {}

class SavePetEvent extends CreatePetInfoEvent {
  final Pet pet;
  final File? imageFile;
  SavePetEvent(this.pet, this.imageFile);
}

// States
abstract class CreatePetInfoState {}

class CreatePetInitial extends CreatePetInfoState {}

class CreatePetLoading extends CreatePetInfoState {}

class CreatePetSuccess extends CreatePetInfoState {}

class CreatePetError extends CreatePetInfoState {
  final String message;
  CreatePetError(this.message);
}

// BLoC
class CreatePetInfoBloc extends Bloc<CreatePetInfoEvent, CreatePetInfoState> {
  final SavePetInfo savePetInfo;

  CreatePetInfoBloc(this.savePetInfo) : super(CreatePetInitial()) {
    on<SavePetEvent>((event, emit) async {
      emit(CreatePetLoading());
      try {
        await savePetInfo(event.pet, event.imageFile);
        emit(CreatePetSuccess());
      } catch (e) {
        emit(CreatePetError(e.toString()));
      }
    });
  }
}
