import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async {
	try {
	  UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
	  return userCredential.user;
	} catch (e) {
	  print(e);
	  return null;
	}
  }

  Future<void> signOut() async {
	await _firebaseAuth.signOut();
  }
}