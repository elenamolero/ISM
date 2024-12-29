import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/data/services/model/user_response.dart';
import 'package:petuco/data/services/user/user_service.dart';
import 'package:petuco/domain/entities/user.entity.dart' as user;

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
        company: userResponse.company,
        cif: userResponse.cif,
      );
    } else {
      return user.User(
        name: '',
        email: '',
        address: '',
        phoneNumber: 0,
        password: '',
        role: '',
        company: '',
        cif: '',
      );
    }
  }

  @override
  Future<void> saveUserInfo(user.User user) async {
    await userService.saveUserInfo(user);
    print('User saved in repository: ${user.name}, ${user.email}, ${user.address}, ${user.phoneNumber}, ${user.password}, ${user.role}, ${user.company}, ${user.cif}');
  }

@override
Future<void> registerUserInfo(user.User user) async {
  try {
    print('UserRepository: Starting registration for user: ${user.name}, ${user.email}, ${user.address}, ${user.phoneNumber}, ${user.password}, ${user.role}, ${user.company}, ${user.cif}');
    await userService.registerUserInfo(user);
    print('UserRepository: Registration successful for user: ${user.name}');
    print('User saved in repository: ${user.name}, ${user.email}, ${user.address}, ${user.phoneNumber}, ${user.password}, ${user.role}, ${user.company}, ${user.cif}');
  } catch (e) {
    print('UserRepository: Registration failed for user: ${user.name}, Error: $e');
    rethrow; // Re-throw the exception after logging it
  }
}
  
  @override
  Future<void> loginUser(user.User loginUser) async{
    await userService.loginUser(loginUser);
  }
  
  @override
  Future<void> logoutUser() {
    return userService.logoutUser();
  }
}