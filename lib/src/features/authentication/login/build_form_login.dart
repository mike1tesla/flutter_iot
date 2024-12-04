import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_app/src/features/authentication/login/bloc/login_cubit.dart';
import 'package:iot_app/src/features/core/home/home_screen.dart';

class BuildFormLogin extends StatefulWidget {
  const BuildFormLogin({
    super.key,
  });

  @override
  State<BuildFormLogin> createState() => _BuildFormLoginState();
}

class _BuildFormLoginState extends State<BuildFormLogin> {
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if(state is LoginLoaded){
          Navigator.of(context).pushNamed(HomeScreen.route);
        } if(state is LoginFailure){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('LOGIN FAILURE')));
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Username", style: TextStyle(fontSize: 16, color: Colors.green, fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            TextFormField(
              controller: emailEditingController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                hintText: "Please enter username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (value) {
                final RegExp _emailRegExp = RegExp(
                  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                );
                if (value == null || value.isEmpty) {
                  return "Username can not empty";
                } else if (_emailRegExp.hasMatch(value)) {
                  return null;
                } else {
                  return "Email invalid";
                }
              },
            ),
            const SizedBox(height: 16),
            const Text("Password", style: TextStyle(fontSize: 16, color: Colors.green, fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordEditingController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.key_outlined),
                hintText: "* * * * * * * *",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                suffixIcon: GestureDetector(
                  onTap: _toggle,
                  child: Icon(
                    _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password can not empty';
                }
                if (value.length < 6) {
                  return "Password invalid";
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final email = emailEditingController.text;
                final password = passwordEditingController.text;
                var isValid = _formKey.currentState?.validate() ?? false;
                if (isValid) {
                  //   Thực hiện CallAPI hoặc Login
                  context.read<LoginCubit>().loginWithEmailAndPassword(email, password);
                } else {
                  //   Không làm gì
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text("LOGIN", style: TextStyle(fontSize: 16, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
