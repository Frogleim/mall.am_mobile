import 'package:firebase_auth/firebase_auth.dart';

String getEmail() {
  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = user?.email ?? '';
  return userEmail;
}
