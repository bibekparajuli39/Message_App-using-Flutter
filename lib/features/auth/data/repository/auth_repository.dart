import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  // Email save to firebase
  Future<void> saveUserToFirestore(
    User user, {
    String provider = 'email',
    String? name,
  }) async {
    await firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'fullname': name ?? user.displayName ?? "",
      'email': user.email,
      'provider': provider,
    }, SetOptions(merge: true));
  }

  // Email SignUp
  Future<UserCredential> signUp(
    String name,
    String email,
    String password,
  ) async {
    final UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(email: email, password: password);
    final User user = userCredential.user!;
    await user.updateDisplayName(name);
    await user.reload();
    final User updateUser = auth.currentUser!;
    await saveUserToFirestore(updateUser, provider: email, name: name);
    return userCredential;
  }

  // Email login
  Future<UserCredential> signIn(String email, String password) async {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User user = userCredential.user!;
    await saveUserToFirestore(user, provider: email);
    return userCredential;
  }

  // Email signOut
  Future<void> signOut() async {
    return await auth.signOut();
  }

  // Email Forget
  Future<void> forget(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }
}
