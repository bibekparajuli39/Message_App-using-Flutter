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

class AuthLogut extends AuthState {}

class PasswordResetSuccess extends AuthState {}
