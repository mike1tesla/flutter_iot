
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/authentication/authentication_repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository}) : super(LoginInitial());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    // Todo: thực hiện gọi hàm login
    print("Username: $email , Password: $password");
    bool isLogin = await authenticationRepository.logInWithEmailAndPassword(email: email, password: password);
    if (isLogin) {
      emit(LoginLoaded());
    } else {
      emit(LoginFailure());
    }
  }

  Future<void> signInAnonymous() async {
    bool signIn = await authenticationRepository.signInAnonymous();
    if (signIn) {
      emit(LoginLoaded());
    } else {
      emit(LoginFailure());
    }
  }
}
