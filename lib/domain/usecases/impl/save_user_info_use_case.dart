import 'package:petuco/domain/usecases/save_user_info_use_case_inteface.dart';
import '../../../data/repository/impl/user_repository.dart';
import '../../entities/user.dart';

class SaveUserInfoUseCase extends SaveUserInfoUseCaseInterface {

  UserRepository userRepository;

  SaveUserInfoUseCase({required this.userRepository});
  
  @override
  Future<void> saveUserInfo(User user) async {
   await userRepository.saveUserInfo(user);
  }
  
}