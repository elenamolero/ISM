import 'package:petuco/domain/entities/user.dart' as user;

abstract class LoginUserUseCaseInterface {
  
  Future<void> call(user.User user);
}
