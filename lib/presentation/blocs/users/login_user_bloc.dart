import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/entities/user.dart';

abstract class LoginUserEvent {}
class UpdateEmailEvent extends LoginUserEvent {
  final String email;
  UpdateEmailEvent(this.email);
}
class UpdatePasswordEvent extends LoginUserEvent {
  final String password;
  UpdatePasswordEvent(this.password);
}
class SubmitLoginEvent extends LoginUserEvent {}

abstract class LoginUserState {}
class LoginUserInitial extends LoginUserState {}
class LoginUserLoading extends LoginUserState {}
class LoginUserSuccess extends LoginUserState {}
class LoginUserError extends LoginUserState {
  final String message;
  LoginUserError(this.message);
}

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final LoginUser loginUserUseCase;
  String email = '';
  String password = '';

  LoginUserBloc(this.loginUserUseCase) : super(LoginUserInitial()) {
    on<UpdateEmailEvent>((event, emit) {
      email = event.email;
    });
    on<UpdatePasswordEvent>((event, emit) {
      password = event.password;
    });
    on<SubmitLoginEvent>((event, emit) async {
      emit(LoginUserLoading());
      try {
        final user = User(
          name: '', 
          email: email,
          address: '',
          phoneNumber: 0,
          password: password,
          role: '',
        );
        final success = await loginUserUseCase.call(user);
        if (success) {
          emit(LoginUserSuccess());
        } else {
          emit(LoginUserError('Incorrect user or password.'));
        }
      } catch (e) {
        emit(LoginUserError('An error occurred during login.'));
      }
    });
  }
}
