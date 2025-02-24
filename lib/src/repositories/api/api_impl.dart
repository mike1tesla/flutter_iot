import 'package:iot_app/src/models/login.dart';
import 'package:iot_app/src/repositories/api/api.dart';
import 'package:iot_app/src/repositories/log/log.dart';

class ApiImpl implements Api {
  Log log;
  ApiImpl(this.log);

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }
  @override
  Future<bool> checkLogin(Login login) async {
    await delay();
    if(login.username == "1" && login.password == "1") return Future(() => true);
    else {
      return Future(() => false);
    }
  }
  
}