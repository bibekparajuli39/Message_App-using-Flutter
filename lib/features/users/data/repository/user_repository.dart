import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRepository({required this.auth, required this.firestore});
}
