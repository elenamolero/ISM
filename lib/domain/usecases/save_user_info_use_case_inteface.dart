import 'package:petuco/domain/entities/user.entity.dart' as user;

abstract class SaveUserInfoUseCaseInterface {
  Future<void> saveUserInfo(user.User user);
}