import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app/main_cubit.dart';
import 'package:iot_app/src/features/authentication/login/login_screen.dart';
import 'package:iot_app/src/features/authentication/splash/splash_screen.dart';
import 'package:iot_app/src/repositories/api/api.dart';
import 'package:iot_app/src/repositories/api/api_impl.dart';
import 'package:iot_app/src/repositories/log/log.dart';
import 'package:iot_app/src/repositories/log/log_impl.dart';
import 'package:iot_app/src/routing/route.dart';

void main() {
  runApp(
    RepositoryProvider<Log>(
      create: (context) => LogImpl(),
      child: Repository(),
    ),
  );
}

class Repository extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Api>(
      create: (context) => ApiImpl(context.read<Log>()),
      child: Provider(),
    );
  }
}

class Provider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: mainRoute,
      initialRoute: SplashScreen.route,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreenAccent,
          brightness: Brightness.light,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
    );
  }
}
