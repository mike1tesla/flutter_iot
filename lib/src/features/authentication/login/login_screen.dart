import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app/src/features/authentication/login/login_cubit.dart';
import 'package:iot_app/src/repositories/api/api.dart';

class LoginScreen extends StatelessWidget {

  static const String route = "LoginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<Api>()),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Text("Login"),
        );
      },
    );
  }
}
