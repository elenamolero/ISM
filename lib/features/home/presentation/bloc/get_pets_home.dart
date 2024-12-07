import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/features/home/domain/usecases/get_pets_home_use_case_interface.dart';
import '../../domain/entities/pet.dart';
// Estados
abstract class PetState {}
class PetInitial extends PetState {}
class PetLoading extends PetState {}
class PetLoaded extends PetState {
  final List<Pet> pets; // Lista de mascotas cargadas
  PetLoaded(this.pets);
}
class PetError extends PetState {
  final String message;
  PetError(this.message);
}

// Eventos
abstract class PetEvent {}
class FetchPets extends PetEvent {}

// BLoC
class PetBloc extends Bloc<PetEvent, PetState> {
  GetPetsUseCaseInterface getPetsUseCase;

  PetBloc({required this.getPetsUseCase}) : super(PetInitial()){
    on<FetchPets>((event, emit) async {
      getPets();
    });
    
  }

  void getPets() async {
      List<Pet> pets = await getPetsUseCase.getPets();
      emit(PetLoaded(pets));
  }
}


