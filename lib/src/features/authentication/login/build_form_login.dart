import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildFormLogin extends StatefulWidget {
  const BuildFormLogin({
    super.key,
  });

  @override
  State<BuildFormLogin> createState() => _BuildFormLoginState();
}

class _BuildFormLoginState extends State<BuildFormLogin> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Username", style: TextStyle(fontSize: 16, color: Colors.green, fontStyle: FontStyle.italic)),
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
          const Text("Password", style: TextStyle(fontSize: 16, color: Colors.green, fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key_outlined),
              hintText: "* * * * * * * *",
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
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              minimumSize: const Size(double.infinity, 55),
            ),
            child: const Text("LOGIN", style: TextStyle(fontSize: 16, color: Colors.white)),
          )
        ],
      ),
    );
  }
}