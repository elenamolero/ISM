import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/user.entity.dart';
import '../../../domain/usecases/login_user.dart';

// Events
abstract class UserEvent {}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;

  LoginUserEvent(this.email, this.password);
}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent(this.user);
}

// States
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoginSuccess extends UserState {
  final User user;
  UserLoginSuccess(this.user);
}

class UserCreateSuccess extends UserState {
  final User user;

  UserCreateSuccess(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUser loginUser;

  UserBloc(this.loginUser) : super(UserInitial()) {
    // Handling login
    on<LoginUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await loginUser(event.email, event.password);
        emit(UserLoginSuccess(user));
      } catch (e) {
        emit(UserError("Failed to log in: ${e.toString()}"));
      }
    });
  }
}
