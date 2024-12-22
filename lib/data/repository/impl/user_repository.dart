import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/data/services/model/user_response.dart';
import 'package:petuco/data/services/user/user_service.dart';
import 'package:petuco/domain/entities/user.dart' as user;

class UserRepository implements UserRepositoryInterface {
    UserService userService = UserService();

    UserRepository({required this.userService});

  @override
  Future<user.User> getUserInfo(String email) async {
    UserResponse? userResponse = await userService.getUserInfo(email);
    if (userResponse != null) {
      return user.User(
        name: userResponse.name,
        email: userResponse.email,
        address: userResponse.address,
        phoneNumber: userResponse.phoneNumber,
        password: userResponse.password,
        role: userResponse.role,
      );
    } else {
      return user.User(
        name: '',
        email: '',
        address: '',
        phoneNumber: 0,
        password: '',
        role: '',
      );
    }
  }

  @override
  Future<void> saveUserInfo(user.User user) async {
    await userService.saveUserInfo(user);
    print('User saved in repository: ${user.name}, ${user.email}, ${user.address}, ${user.phoneNumber}, ${user.password}, ${user.role}');
  }
  
  @override
  Future<bool> loginUser(user.User user) {
    return userService.loginUser(user);
  }
}