// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:api_project/src/screens/posts_screen.dart';
import 'package:api_project/src/services/auth.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // username field
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            // password field
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            // login button
            TextButton(
              onPressed: () async {
                try{
                  final authservice = AuthService();
                  await authservice.login(
                    usernameController.text,
                    passwordController.text,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PostsScreen())
                  );
                }catch(error){
                  debugPrint(error.toString());
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
