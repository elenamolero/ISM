import 'package:petuco/domain/entities/user.dart';


class Vet extends User {
  final String nameBusiness;
  final String cifBusiness;

  Vet({
    required String name,
    required String email,
    required String address,
    required String password,
    required String role,
    required int phoneNumber,
    required this.nameBusiness,
    required this.cifBusiness,
  }) : super(
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          address: address,
          role: role,
        );
}

