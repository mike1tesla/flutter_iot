import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }catch (e){
      print(e);
    }
  }
}
