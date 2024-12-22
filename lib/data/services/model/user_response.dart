class UserResponse {
  final int id;
  final String name;
  final String email;
  final String address;
  final int phoneNumber;
  final String password;
  final String role;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.password,
    required this.role,
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
    );
  }
}
