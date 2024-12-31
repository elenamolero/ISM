import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/user.entity.dart';
import 'package:petuco/domain/usecases/register_user_use_case_interface.dart';

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

//Bloc
class RegisterUserInfoBloc
    extends Bloc<RegisterUserEvent, RegisterUserInfoState> {
  final RegisterUserUseCaseInterface registerUserInfoUseCase;

  RegisterUserInfoBloc({required this.registerUserInfoUseCase})
      : super(RegisterUserInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterUserLoading());
      try {
        // Attempt to register the user
        await registerUserInfoUseCase.registerUserInfo(event.user);
        emit(RegisterUserSuccess());
      } catch (e) {
        // Check for a specific error, e.g., "User already exists"
        String errorMessage;
        if (e.toString().contains("User already registered")) {
          errorMessage = "This email already exists in the database.";
        } else {
          errorMessage = "Failed to save new user info.";
        }
        emit(RegisterUserError(errorMessage));
      }
    });
  }
}
