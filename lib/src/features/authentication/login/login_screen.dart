import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildPageTitle(),
                    const SizedBox(height: 32),
                    _buildFormLogin(),
                    const SizedBox(height: 10),
                    _buildOrSplitDivider(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Container buildPageTitle() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue),
      ),
      child: const Center(
        child: Text(
          "Login",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFormLogin() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Username", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Please enter username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Password", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "* * * * * * * *",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              minimumSize: const Size(double.infinity, 55),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildOrSplitDivider(){
    return Row(
      children: [
        Expanded(child: Container(height: 2, width: double.infinity, color: Colors.grey.shade200,)),
        const Text("Or"),
        Expanded(child: Container(height: 2, width: double.infinity, color: Colors.grey.shade200,)),
      ],
    );
  }
}


