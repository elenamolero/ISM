//Events

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/pet.entity.dart';
import 'package:petuco/domain/usecases/nfc_use_case_interface.dart';

abstract class NFCInfoEvent {}

class NFCEvent extends NFCInfoEvent {
  final Pet pet;
  NFCEvent(this.pet);
}

//States

abstract class NFCState {}

class NFCInitial extends NFCState {}
class NFCLoading extends NFCState {}
class NFCSuccess extends NFCState {}
class NFCError extends NFCState {
  final String message;
  NFCError(this.message);
}

// BLoC
class NFCBloc extends Bloc<NFCEvent, NFCState> {
  NFCUseCaseInterface nfcUseCase;

  NFCBloc({required this.nfcUseCase}) : super(NFCInitial()) {
    on<NFCEvent>((event, emit) async {
      emit(NFCLoading());
      try {
        nfcUseCase.nfcInfo(event.pet);
        emit(NFCSuccess());
      } catch (e) {
        emit(NFCError("Failed to save new user info") as NFCState);
      }
    });
  }
}