abstract class AuthEvent {}

class EmailLogin extends AuthEvent {
  final String email;

  final String password;
  EmailLogin({required this.email, required this.password});
}

class EmailSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  EmailSignUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

class EmailForget extends AuthEvent {
  final String email;
  EmailForget({required this.email});
}
