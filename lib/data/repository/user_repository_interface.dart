import '../../domain/entities/user.dart' as user;

abstract class UserRepositoryInterface {
  Future<user.User> getUserInfo(String email);
  
  Future<void> saveUserInfo(user.User user);

  Future<void> registerUserInfo(user.User user);

  Future<bool> loginUser(user.User user);
}