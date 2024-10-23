import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../login/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = "SignUpScreen";

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: [
              _buildRegisterTitle(),
              const SizedBox(height: 20),
              const BuildFormRegister(),
              const SizedBox(height: 20),
              const BuildOrSplitDivider(),
              const SizedBox(height: 20),
              _buildRegisterWithPlatform(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRegisterTitle(){
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),

      ),
      child: const Center(child: Text("Register", style: TextStyle(fontSize: 25, color: Colors.redAccent))),
    );
  }


  Widget _buildRegisterWithPlatform(BuildContext context) {
    return Column(
      children: [
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
              SvgPicture.asset("assets/svg/google.svg", height: 20, width: 20, fit: BoxFit.contain),
              const SizedBox(width: 25),
              const Text("Register with Google", style: TextStyle(fontSize: 16)),
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
              const Text("Register with Facebook", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildFormRegister extends StatefulWidget {
  const BuildFormRegister({
    super.key,
  });

  @override
  State<BuildFormRegister> createState() => _BuildFormRegisterState();
}

class _BuildFormRegisterState extends State<BuildFormRegister> {
  bool _obscureText = true;
  bool _obscureTextPassword = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline_outlined),
            hintText: "Please enter username",
            labelText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key_outlined),
              hintText: "* * * * * * * *",
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            suffixIcon: GestureDetector(
              onTap: _togglePassword,
              child: Icon(
                _obscureTextPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                color: Colors.black,
                size: 15,
              ),
            ),
          ),
          obscureText: _obscureTextPassword,
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key_outlined),
              hintText: "* * * * * * * *",
              labelText: "Confirm pasword",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            suffixIcon: GestureDetector(
              onTap: _toggle,
              child: Icon(
                _obscureText
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                color: Colors.black,
                size: 15,
              ),
            ),
          ),
          obscureText: _obscureText,
        ),
      ],
    );
  }
}
