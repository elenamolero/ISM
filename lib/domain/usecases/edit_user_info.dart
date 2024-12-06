import '../entities/user.dart';
class EditUserInfo {
  Future<void> call(User user) async {
    //All business rules has to be here (validations, rules...)
    print(
        'User info saved correctly: ${user.name}, ${user.email}, ${user.address}, ${user.phoneNumber}, ${user.password}, ${user.role}');
  }
}