import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petuco/domain/entities/user.dart';
import 'package:petuco/domain/usecases/get_user_info_use_case_interface.dart';

//Events

abstract class GetUserInfoEvent {}

class GetUserEvent extends GetUserInfoEvent {
  final String email;
  GetUserEvent(this.email);
}

//States

abstract class GetUserInfoState {}

class GetUserInitial extends GetUserInfoState {}
class GetUserLoading extends GetUserInfoState {}
class GetUserSuccess extends GetUserInfoState {
  final User userInfo;

  GetUserSuccess(this.userInfo);
}
class GetUserError extends GetUserInfoState {
  final String message;
  GetUserError(this.message);
}

// BLoC
class GetUserInfoBloc extends Bloc<GetUserEvent, GetUserInfoState> {
  GetUserInfoUseCaseInterface getUserInfoUseCase;

  GetUserInfoBloc({required this.getUserInfoUseCase}) : super(GetUserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(GetUserLoading());
      try {
        Future<User> user = getUserInfoUseCase.getUserInfo(event.email);
        emit(GetUserSuccess(await user));
      } catch (e) {
        emit(GetUserError("Failed to get user info") as GetUserInfoState);
      }
    });
  }
}