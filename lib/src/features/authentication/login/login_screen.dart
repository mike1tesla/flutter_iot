import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_app/src/features/authentication/login/bloc/login_cubit.dart';
import 'package:iot_app/src/features/authentication/signup/signup_screen.dart';
import 'package:iot_app/src/repositories/authentication/authentication_repositories.dart';

import 'build_form_login.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "LoginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authenticationRepository = context.read<AuthenticationRepository>();
        return LoginCubit(authenticationRepository: authenticationRepository);
      },
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPageTitle(),
                  const SizedBox(height: 16),
                  const BuildFormLogin(),
                  const SizedBox(height: 16),
                  const BuildOrSplitDivider(),
                  const SizedBox(height: 16),
                  _buildLoginWithPlatform(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPageTitle() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue),
      ),
      child: const Center(
        child: Text("Login", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLoginWithPlatform(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<LoginCubit>().signInAnonymous();
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 55),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svg/google.svg", height: 20, width: 20, fit: BoxFit.contain),
              const SizedBox(width: 25),
              const Text("Login with Google", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 55),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svg/facebook.svg", height: 20, width: 20, fit: BoxFit.contain),
              const SizedBox(width: 25),
              const Text("Login with Facebook", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: "Register",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed(SignUpScreen.route);
                  },
              )
            ],
          ),
        )
      ],
    );
  }
}

class BuildOrSplitDivider extends StatelessWidget {
  const BuildOrSplitDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 2,
          width: double.infinity,
          color: Colors.grey.shade200,
        )),
        Text("Or", style: TextStyle(color: Colors.grey.shade500)),
        Expanded(
            child: Container(
          height: 2,
          width: double.infinity,
          color: Colors.grey.shade200,
        )),
      ],
    );
  }
}
