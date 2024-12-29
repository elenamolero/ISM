import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/usecases/impl/login_user_use_case.dart';
import 'package:petuco/domain/entities/user.entity.dart' as petuco;
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final LoginUserUseCase loginUserUseCase;
  String email = '';
  String password = '';

  LoginUserBloc({required this.loginUserUseCase}) : super(LoginUserInitial()) {
    on<UpdateEmailEvent>((event, emit) {
      email = event.email;
    });
    on<UpdatePasswordEvent>((event, emit) {
      password = event.password;
    });

    on<SubmitLoginEvent>((event, emit) async {
      emit(LoginUserLoading());
      try {
        final user = petuco.User(
          name: '', 
          email: email,
          address: '',
          phoneNumber: 0,
          password: password,
          role: '',
        );

        await loginUserUseCase.call(user); // Llama al caso de uso

        emit(LoginUserSuccess()); // Emite estado de éxito si no hay errores
      } on AuthException catch (e) {
        // Captura y maneja el error de autenticación
        if (e.message.contains('Invalid login credentials')) {
          emit(LoginUserError('Invalid Email or password'));
        } else {
          emit(LoginUserError('Error de autenticación: ${e.message}'));
        }
      } catch (e) {
        emit(LoginUserError('Ocurrió un error inesperado.'));
      }
    });
  }
}
