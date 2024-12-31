import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/usecases/impl/forgot_user_use_case.dart'; // Use case for retrieving the username
import 'package:supabase_flutter/supabase_flutter.dart';

/// Events
abstract class ForgotUserEvent {}

class UpdateEmailEvent extends ForgotUserEvent {
  final String email;
  UpdateEmailEvent(this.email);
}

class SubmitForgotUserEvent extends ForgotUserEvent {}

/// States
abstract class ForgotUserState {}

class ForgotUserInitial extends ForgotUserState {}

class ForgotUserLoading extends ForgotUserState {}

class ForgotUserSuccess extends ForgotUserState {
  final String email;
  ForgotUserSuccess(this.email);
}

class ForgotUserError extends ForgotUserState {
  final String message;
  ForgotUserError(this.message);
}

/// Bloc
class ForgotUserBloc extends Bloc<ForgotUserEvent, ForgotUserState> {
  final ForgotUserUseCase
      forgotUserUseCase; // Use case to retrieve the username
  String email = '';

  ForgotUserBloc({required this.forgotUserUseCase})
      : super(ForgotUserInitial()) {
    // Event to update the email
    on<UpdateEmailEvent>((event, emit) {
      email = event.email;
    });

    // Event to submit the username retrieval request
    on<SubmitForgotUserEvent>((event, emit) async {
      emit(ForgotUserLoading());
      try {
        // Call the use case to send the username to the provided email
        await forgotUserUseCase.call(email);

        emit(ForgotUserSuccess(email)); // Emit success state
      } on AuthException catch (e) {
        // Handle authentication exceptions
        emit(ForgotUserError('Error: ${e.message}'));
      } catch (e) {
        // Handle unexpected errors
        emit(ForgotUserError('An unexpected error occurred.'));
      }
    });
  }
}
