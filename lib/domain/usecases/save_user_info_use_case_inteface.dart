import 'package:petuco/domain/entities/user.dart' as user;

abstract class SaveUserInfoUseCaseInterface {
  Future<void> saveUserInfo(user.User user);
}