class UserResponse {
  final int id;
  final String name;
  final String email;
  final String address;
  final int phoneNumber;
  final String password;
  final String role;
  final String? company;
  final String? cif;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.password,
    required this.role,
    this.company,
    this.cif,
  });

  static UserResponse toDomain(Map<String, dynamic>? map) {
    return UserResponse(
      id: map?['id'] ?? 0,
      name: map?['name'] ?? '',
      email: map?['email'] ?? '',
      address: map?['address'] ?? '',
      phoneNumber: map?['phoneNumber'] ?? 0,
      password: map?['password'] ?? '',
      role: map?['role'] ?? '',
      company: map?['company'],
      cif: map?['cif'],
    );
  }
}
