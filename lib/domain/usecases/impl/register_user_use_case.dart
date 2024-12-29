import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/domain/usecases/register_user_use_case_interface.dart';
import '../../../data/repository/impl/user_repository.dart';
import '../../entities/user.entity.dart';

class RegisterUserInfoUseCase extends RegisterUserUseCaseInterface {

  UserRepositoryInterface userRepositoryInterface;

  RegisterUserInfoUseCase({required this.userRepositoryInterface});
  
  @override
  Future<void> registerUserInfo(User user) async {
    try {
      print('RegisterUserInfoUseCase: Starting registration for user: ${user.name}');
      await userRepositoryInterface.registerUserInfo(user);
      print('RegisterUserInfoUseCase: Registration successful for user: ${user.name}');
    } catch (e) {
      print('RegisterUserInfoUseCase: Registration failed for user: ${user.name}, Error: $e');
      rethrow; // Re-throw the exception after logging it
    }
  }
}