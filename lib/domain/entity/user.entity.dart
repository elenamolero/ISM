// Class User and attributes
class User{
  final String name;
  final String email;
  final String address;
  final int phoneNumber;
  final String password;
  final String role;

  //To define the required fields
  User(
      {required this.name,
      required this.email,
      required this.address,
      required this.phoneNumber,
      required this.password,
      required this.role}
  );
}