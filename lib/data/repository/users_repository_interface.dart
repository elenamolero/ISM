import 'package:petuco/domain/entity/user.entity.dart';

abstract class UsersRepositoryInterface {
  Future<void> loginUser(User user);
}
