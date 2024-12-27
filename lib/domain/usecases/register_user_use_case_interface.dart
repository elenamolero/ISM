import 'package:petuco/domain/entities/user.dart' as user;

abstract class RegisterUserUseCaseInterface {
  Future<void> registerUserInfo(user.User user);
}