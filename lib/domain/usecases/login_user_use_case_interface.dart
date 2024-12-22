import 'package:petuco/domain/entities/user.dart' as user;

abstract class LoginUserUseCaseInterface {
  
  Future<bool> call(user.User user);
}
