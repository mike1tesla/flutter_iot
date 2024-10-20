import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPageTitle(),
                  const SizedBox(height: 16),
                  _buildFormLogin(),
                  const SizedBox(height: 16),
                  _buildOrSplitDivider(),
                  const SizedBox(height: 16),
                  _buildLoginWithPlatform(),
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
          const Text("Username", style: TextStyle(fontSize: 16, color: Colors.green,fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline_outlined),
              hintText: "Please enter username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Password",style: TextStyle(fontSize: 16, color: Colors.green,fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key_outlined),
              hintText: "* * * * * * * *",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              suffixIcon: const Icon(Icons.remove_red_eye_outlined)
            ),
            obscureText: true,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              minimumSize: const Size(double.infinity, 55),
            ),
            child: const Text(
              "LOGIN",
              style: TextStyle(fontSize: 16, color: Colors.white),
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
        Text("Or",style: TextStyle(color: Colors.grey.shade500),),
        Expanded(child: Container(height: 2, width: double.infinity, color: Colors.grey.shade200,)),
      ],
    );
  }
  Widget _buildLoginWithPlatform(){
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
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
              SizedBox(width: 20, height: 20, child: SvgPicture.asset("assets/svg/google.svg")),
              const SizedBox(width: 25,),
              const Text("Login with Google", style: TextStyle(fontSize: 16),),
            ],
          ),
        ),
        const SizedBox( height: 15,),
        OutlinedButton(
          onPressed: () {
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
              SizedBox(width: 20, height: 20, child: SvgPicture.asset("assets/svg/facebook.svg")),
              const SizedBox(width: 25,),
              const Text("Login with Facebook", style: TextStyle(fontSize: 16),),
            ],
          ),
        ),
      ],
    );
  }
}


