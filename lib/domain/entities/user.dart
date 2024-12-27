//This is the class User and all his attributes
class User {
  final String name;
  final String email;
  final String address;
  final int phoneNumber;
  final String password;
  final String role;
  final String? company;
  final String? cif;

//All required fields from class User
  User(
      {required this.name,
      required this.email,
      required this.address,
      required this.phoneNumber,
      required this.password,
      required this.role,
      this.company,
      this.cif
      }
      );
}