import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/user.dart';
import 'package:petuco/domain/usecases/save_user_info_use_case_inteface.dart';

//Events

abstract class SaveUserInfoEvent {}

class SaveUserEvent extends SaveUserInfoEvent {
  final User user;
  SaveUserEvent(this.user);
}

//States

abstract class SaveUserInfoState {}

class SaveUserInitial extends SaveUserInfoState {}
class SaveUserLoading extends SaveUserInfoState {}
class SaveUserSuccess extends SaveUserInfoState {}
class SaveUserError extends SaveUserInfoState {
  final String message;
  SaveUserError(this.message);
}

// BLoC
class SaveUserInfoBloc extends Bloc<SaveUserEvent, SaveUserInfoState> {
  SaveUserInfoUseCaseInterface saveUserInfoUseCase;

  SaveUserInfoBloc({required this.saveUserInfoUseCase}) : super(SaveUserInitial()) {
    on<SaveUserEvent>((event, emit) async {
      emit(SaveUserLoading());
      try {
        saveUserInfoUseCase.saveUserInfo(event.user);
        emit(SaveUserSuccess());
      } catch (e) {
        emit(SaveUserError("Failed to save new user info") as SaveUserInfoState);
      }
    });
  }
}