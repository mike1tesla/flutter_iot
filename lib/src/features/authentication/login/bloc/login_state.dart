
part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoaded extends LoginState {}
class LoginFailure extends LoginState {}
