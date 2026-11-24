import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/features/auth/bloc/auth_event.dart';
import 'package:message_app/features/auth/bloc/auth_state.dart';
import 'package:message_app/features/auth/data/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthIntial()) {
    on<EmailSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await repository.signUp(
          event.name,
          event.email,
          event.password,
        );
        if (response.user != null) {
          emit(AuthAuthenticate(user: response.user!));
        } else {
          emit(AuthError('Account creation failed'));
        }
      } on FirebaseAuthException catch (e) {
        String message = "Account creation faileds";
        if (e.code == 'email-already-in-use') {
          message = 'This email is already registered';
        } else if (e.code == 'invalid-email') {
          message = 'Please enter a valid email';
        } else if (e.code == 'weak-password') {
          message = 'Password is too weak';
        } else if (e.code == 'operation-not-allowed') {
          message = 'Email/password login is not enabled';
        }
        emit(AuthError(message));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<EmailLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await repository.signIn(event.email, event.password);
        if (response.user != null) {
          emit(AuthAuthenticate(user: response.user!));
        } else {
          emit(AuthError('Login failed'));
        }
      } on FirebaseAuthException catch (e) {
        String message = "Login failed";
        if (e.code == 'user-not-found') {
          message = 'No user found';
        } else if (e.code == 'wrong-password') {
          message = 'Incorrect password';
        } else if (e.code == 'invalid-credential') {
          message = 'Incorrect email and password';
        } else if (e.code == 'invalid-email') {
          message = 'Incorrect email';
        }
        emit(AuthError(message));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<EmailForget>((event, emit) async {
      emit(AuthLoading());
      try {
        await repository.forget(event.email);
        emit(PasswordResetSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthError(e.message ?? 'Something went wrong'));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on((event, emit) {});
  }
}
