import 'package:petuco/data/repository/impl/user_repository.dart';
import 'package:petuco/domain/usecases/login_user_use_case_interface.dart';
import '../../entities/user.entity.dart' as user;

class LoginUserUseCase implements LoginUserUseCaseInterface {

  UserRepository userRepository;

  LoginUserUseCase({required this.userRepository});
  
  @override
  Future<void> call(user.User user) async {
    await userRepository.loginUser(user);
  }

}
