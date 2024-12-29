import 'package:petuco/data/repository/impl/user_repository.dart';
import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/domain/usecases/login_user_use_case_interface.dart';
import '../../entities/user.entity.dart' as user;

class LoginUserUseCase implements LoginUserUseCaseInterface {

  UserRepositoryInterface userRepositoryInterface;

  LoginUserUseCase({required this.userRepositoryInterface});
  
  @override
  Future<void> call(user.User user) async {
    await userRepositoryInterface.loginUser(user);
  }

}
