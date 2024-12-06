import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app/main_cubit.dart';
import 'package:iot_app/src/features/authentication/splash/splash_screen.dart';
import 'package:iot_app/src/features/core/home/home_screen.dart';
import 'package:iot_app/src/features/gemini_chat/gemini_chat.dart';
import 'package:iot_app/src/repositories/api/api.dart';
import 'package:iot_app/src/repositories/api/api_impl.dart';
import 'package:iot_app/src/repositories/authentication/authentication_repositories.dart';
import 'package:iot_app/src/repositories/data_source/firebase_auth_service.dart';
import 'package:iot_app/src/repositories/log/log.dart';
import 'package:iot_app/src/repositories/log/log_impl.dart';
import 'package:iot_app/src/routing/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Log>(
          create: (context) => LogImpl(),
        ),
        // RepositoryProvider(
        //   create: (context) => FirebaseAuthService(),
        // ),
      ],
      child: Repository(),
    ),
  );
}

class Repository extends StatefulWidget {
  @override
  State<Repository> createState() => _RepositoryState();
}

class _RepositoryState extends State<Repository> {
  late final AuthenticationRepository _authenticationRepository;
  late final FirebaseAuthService _firebaseAuthService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseAuthService = FirebaseAuthService();
    _authenticationRepository = AuthenticationRepositoryImpl(firebaseAuthService: _firebaseAuthService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Api>(create: (context) => ApiImpl(context.read<Log>())),
        RepositoryProvider<AuthenticationRepository>(create: (context) => _authenticationRepository),
      ],
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
      initialRoute: GeminiChat.route,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.light,
          background: Colors.white,
          // secondary: Colors.white
        ),
        useMaterial3: true,
      ),
    );
  }
}
