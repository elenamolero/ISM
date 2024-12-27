import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import '../../../domain/usecases/update_pet_info.dart';

// Events
abstract class UpdatePetInfoEvent {}

class LoadPetEvent extends UpdatePetInfoEvent {
  final int petId;
  LoadPetEvent(this.petId);
}

class UpdatePetEvent extends UpdatePetInfoEvent {
  final Pet pet;
  final File? imageFile;
  UpdatePetEvent(this.pet, this.imageFile);
}

// States
abstract class UpdatePetInfoState {}

class UpdatePetInitial extends UpdatePetInfoState {}

class UpdatePetLoading extends UpdatePetInfoState {}

class PetLoaded extends UpdatePetInfoState {
  final Pet pet;
  PetLoaded(this.pet);
}

class UpdatePetSuccess extends UpdatePetInfoState {}

class UpdatePetError extends UpdatePetInfoState {
  final String message;
  UpdatePetError(this.message);
}

// BLoC
class UpdatePetInfoBloc extends Bloc<UpdatePetInfoEvent, UpdatePetInfoState> {
  final UpdatePetInfo updatePetInfo;
  final PetsRepositoryInterface repository;

  UpdatePetInfoBloc({required this.updatePetInfo, required this.repository})
      : super(UpdatePetInitial()) {
    on<LoadPetEvent>((event, emit) async {
      emit(UpdatePetLoading());
      try {
        final pet = await repository.getPetById(event.petId);
        if (pet != null) {
          emit(PetLoaded(pet));
        } else {
          emit(UpdatePetError('Pet not found'));
        }
      } catch (e) {
        emit(UpdatePetError(e.toString()));
      }
    });

    on<UpdatePetEvent>((event, emit) async {
      emit(UpdatePetLoading());
      try {
        await updatePetInfo(event.pet, event.imageFile);
        emit(UpdatePetSuccess());
      } catch (e) {
        print('Error in UpdatePetInfoBloc: $e');
        emit(UpdatePetError(e.toString()));
      }
    });
  }
}
