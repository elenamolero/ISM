import '../../../domain/entity/user.entity.dart';
import '../users_repository_interface.dart';

class UserRepositoryImpl implements UsersRepositoryInterface {
  @override
  Future<void> loginUser(User user) async {
    //All related with the logic when saving data(API, database, etc...)
    print('User logged in repository: ${user.name}');
  }
}
