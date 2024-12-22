import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/user.dart';
import 'package:petuco/domain/usecases/register_user_use_case_interface.dart';
import 'package:petuco/domain/usecases/save_user_info_use_case_inteface.dart';

//Events

abstract class RegisterUserInfoEvent {}

class RegisterUserEvent extends RegisterUserInfoEvent {
  final User user;
  RegisterUserEvent(this.user);
}

//States

abstract class RegisterUserInfoState {}

class RegisterUserInitial extends RegisterUserInfoState {}
class RegisterUserLoading extends RegisterUserInfoState {}
class RegisterUserSuccess extends RegisterUserInfoState {}
class RegisterUserError extends RegisterUserInfoState {
  final String message;
  RegisterUserError(this.message);
}

// BLoC
class RegisterUserInfoBloc extends Bloc<RegisterUserEvent, RegisterUserInfoState> {
  RegisterUserUseCaseInterface registerUserInfoUseCase;

  RegisterUserInfoBloc({required this.registerUserInfoUseCase}) : super(RegisterUserInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterUserLoading());
      try {
        registerUserInfoUseCase.registerUserInfo(event.user);
        emit(RegisterUserSuccess());
      } catch (e) {
        emit(RegisterUserError("Failed to save new user info") as RegisterUserInfoState);
      }
    });
  }
}