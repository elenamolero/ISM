import '../entity/user.entity.dart';

class LoginUser {
  Future<User> call(String email, String password) async {
    // Logic for authenticating the user
    // Example:
    return User(
      name: "John Doe",
      email: email,
      address: "123 Main St",
      phoneNumber: "123-456-7890",
      password: password,
      role: "user",
    );
  }
}
