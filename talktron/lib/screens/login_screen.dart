import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talktron/model/UserProfileModel.dart';
import 'package:talktron/providers/login_providers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    check_user_login(context);
    super.initState();
  }

  void dispose() {
    check_user_login(context);
    signInWithGoogle();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
        centerTitle: true,
      ),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            await signInWithGoogle().then((value) async => {
                  await createUser().then((value) => {
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/chat_list_screen', (route) => false)
                        context.pushReplacement(
                          '/chatlist',
                        )
                      }),
                });
          },
          child: const Text("Sign in with google"),
        ),
      ),
    );
  }
}
