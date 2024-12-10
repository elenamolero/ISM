import 'package:petuco/domain/entities/user.dart' as user;

abstract class GetUserInfoUseCaseInterface {
  Future<user.User> getUserInfo(String email);
}