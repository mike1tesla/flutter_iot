import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app/src/utils/enum/load_status.dart';

import '../../../../repositories/authentication/authentication_repositories.dart';



part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository}) : super(const LoginState.init());


  Future<void> loginWithEmailAndPassword(String email, String password) async {
  // Todo: thực hiện gọi hàm login
    print("Username: $email , Password: $password");
    authenticationRepository.logInWithEmailAndPassword(email: email, password: password);
  }
}
