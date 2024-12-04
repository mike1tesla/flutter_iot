import 'package:iot_app/src/repositories/data_source/firebase_auth_service.dart';

abstract class AuthenticationRepository {
  Future<bool> logInWithEmailAndPassword({required String email, required String password});
  Future<bool> signInAnonymous();
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuthService firebaseAuthService;

  AuthenticationRepositoryImpl({required this.firebaseAuthService});

  @override
  Future<bool> logInWithEmailAndPassword({required String email, required String password}) async {
    return firebaseAuthService.logInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<bool> signInAnonymous() {
    return firebaseAuthService.signInAnonymous();
  }
}
