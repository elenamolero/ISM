import '../entity/user.entity.dart';

class CreateUser {
  Future<User> call(User user) async {
    // Logic for creating a new user
    // Example:
    return User(
        name: user.name,
        email: user.email,
        address: user.address,
        phoneNumber: user.phoneNumber,
        password: user.password,
        role: user.role);
  }
}
