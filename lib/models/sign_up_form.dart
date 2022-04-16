/*
This model holds the information for signing up a user. 
*/
class SignUpForm {
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  SignUpForm(
      {required this.email,
      required this.username,
      required this.password,
      required this.firstName,
      required this.lastName});
}
