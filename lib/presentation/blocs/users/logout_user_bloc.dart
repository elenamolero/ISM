import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/usecases/impl/logout_user_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LogoutUserEvent {}

class SubmitLogoutEvent extends LogoutUserEvent {}

abstract class LogoutUserState {}
class LogoutUserInitial extends LogoutUserState {}
class LogoutUserLoading extends LogoutUserState {}
class LogoutUserSuccess extends LogoutUserState {}
class LogoutUserError extends LogoutUserState {
  final String message;
  LogoutUserError(this.message);
}

class LogoutUserBloc extends Bloc<LogoutUserEvent, LogoutUserState> {
  final LogoutUserUseCase logoutUserUseCase;

  LogoutUserBloc({required this.logoutUserUseCase}) : super(LogoutUserInitial()) {

    on<SubmitLogoutEvent>((event, emit) async {
      emit(LogoutUserLoading());
      try {

        await logoutUserUseCase.call();

        emit(LogoutUserSuccess());
      } on AuthException catch (e) {
        if (e.message.contains('Invalid logout')) {
          emit(LogoutUserError('Invalid logout'));
        } else {
          emit(LogoutUserError('Error de logout: ${e.message}'));
        }
      } catch (e) {
        emit(LogoutUserError('Ocurrió un error inesperado.'));
      }
    });
  }
}
