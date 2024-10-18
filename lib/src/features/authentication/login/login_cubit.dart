import 'package:bloc/bloc.dart';
import 'package:iot_app/src/utils/enum/load_status.dart';
import 'package:iot_app/src/models/login.dart';
import 'package:iot_app/src/repositories/api/api.dart';
import 'package:meta/meta.dart';

import '../../../utils/enum/load_status.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Api api;

  LoginCubit(this.api) : super(const LoginState.init());

  Future<void> checkLogin(Login login) async{
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.checkLogin(login);
    if(result){
      emit(state.copyWith(loadStatus: LoadStatus.Done));
    } else {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }
}
