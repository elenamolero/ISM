import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/edit_user_info.dart';
//Events
abstract class EditUserInfoEvent {}
class EditUserEvent extends EditUserInfoEvent {
  final User user;
  EditUserEvent(this.user);
}
//States
abstract class EditUserInfoState {}
class EditUserInitial extends EditUserInfoState {}
class EditUserLoading extends EditUserInfoState {}
class EditUserSuccess extends EditUserInfoState {}
class EditUserError extends EditUserInfoState {
  final String message;
  EditUserError(this.message);
}
// BLoC
class EditUserInfoBloc extends Bloc<EditUserInfoEvent, EditUserInfoState> {
  final EditUserInfo editUserInfo;
  EditUserInfoBloc(this.editUserInfo) : super(EditUserInitial()) {
    on<EditUserEvent>((event, emit) async {
      emit(EditUserLoading());
      try {
        await editUserInfo(event.user);
        emit(EditUserSuccess());
      } catch (e) {
        emit(EditUserError("Failed to save user info") as EditUserInfoState);
      }
    });
  }
}