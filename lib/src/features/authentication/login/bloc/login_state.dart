part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus loadStatus;

  const LoginState({required this.loadStatus});

  const LoginState.init({
    this.loadStatus = LoadStatus.Init,
  });

  @override
  List<Object?> get props => [loadStatus];

  LoginState copyWith({LoadStatus? loadStatus}) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }
}
