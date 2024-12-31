import 'package:petuco/data/repository/impl/user_repository.dart';

class ForgotUserUseCaseImpl {
  final UserRepository userRepository;

  ForgotUserUseCaseImpl(this.userRepository);

  @override
  Future<void> call(String email) async {
    if (email.isEmpty) {
      throw Exception('Email cannot be empty');
    }

    // Call the repository to retrieve and send the username
    await userRepository.sendUsernameToEmail(email);
  }
}
