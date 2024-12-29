import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/domain/usecases/logout_user_use_case_interface.dart';

class LogoutUserUseCase implements LogoutUserUseCaseInterface {

  UserRepositoryInterface userRepositoryInterface;

  LogoutUserUseCase({required this.userRepositoryInterface});
  
  @override
  Future<void> call() async {
    await userRepositoryInterface.logoutUser();
  }

}
