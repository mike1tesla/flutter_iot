import '../../models/login.dart';

abstract class Api {
  Future<bool> checkLogin(Login login);
}