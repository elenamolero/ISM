import 'package:petuco/domain/entities/user.entity.dart' as user;

abstract class LoginUserUseCaseInterface {
  
  Future<void> call(user.User user);
}
