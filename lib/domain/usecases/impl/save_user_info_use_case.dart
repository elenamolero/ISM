import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/domain/usecases/save_user_info_use_case_inteface.dart';
import '../../entities/user.entity.dart';

class SaveUserInfoUseCase extends SaveUserInfoUseCaseInterface {

  UserRepositoryInterface userRepositoryInterface;

  SaveUserInfoUseCase({required this.userRepositoryInterface});
  
  @override
  Future<void> saveUserInfo(User user) async {
    await userRepositoryInterface.saveUserInfo(user);
  }
  
}