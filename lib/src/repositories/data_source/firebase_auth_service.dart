import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<bool> logInWithEmailAndPassword({required String email, required String password}) async {
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if(user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> signInAnonymous () async {
    try {
      final User? user = (await FirebaseAuth.instance.signInAnonymously()).user;
      print("User Anonymous: ${user?.isAnonymous}");
      print("User id: ${user?.uid}");
      if(user != null){
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
