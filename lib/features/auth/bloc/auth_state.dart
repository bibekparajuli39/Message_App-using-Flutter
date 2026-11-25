import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthIntial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthAuthenticate extends AuthState {
  final User user;
  AuthAuthenticate({required this.user});
}

class AuthLogout extends AuthState {}

// forget password
class PasswordResetLoading extends AuthState {}

class PasswordResetSuccess extends AuthState {}

class PasswordResetError extends AuthState {
  final String message;
  PasswordResetError({required this.message});
}
