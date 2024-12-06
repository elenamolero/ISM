import '../../domain/entities/user.dart';
abstract class UserRespository {
  Future<void> saveUserInfo(User user);
}
class UserRepositoryImpl implements UserRespository {
  @override
  Future<void> saveUserInfo(User user) async {
    //All related with the logic when saving data(API, database, etc...)
    print('User saved in repository: ${user.name}');
  }
}