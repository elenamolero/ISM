import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/domain/usecases/get_user_info_use_case_interface.dart';
import '../../entities/user.entity.dart';

class GetUserInfoUseCase extends GetUserInfoUseCaseInterface {

  UserRepositoryInterface userRepositoryInterface;

  GetUserInfoUseCase({required this.userRepositoryInterface});
  
  @override
  Future<User> getUserInfo(String email) async {
    return await userRepositoryInterface.getUserInfo(email);
  }
  
}