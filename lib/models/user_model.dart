class UserModel {
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String token;
  final String joiningDate;

  UserModel(
      {required this.email,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.token,
      required this.joiningDate});
}
