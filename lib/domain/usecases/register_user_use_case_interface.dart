import 'package:petuco/domain/entities/user.entity.dart' as user;

abstract class RegisterUserUseCaseInterface {
  Future<void> registerUserInfo(user.User user);
}