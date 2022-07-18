import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Please Verify Your Email Address '),
            TextButton(
                onPressed: () async {
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                    devtools.log('Inside email send code');
                  } catch (e) {
                    devtools.log('Error occured with code');
                    devtools.log(e.toString());
                  }
                },
                child: const Text('Send Verification Email'))
          ],
        ),
      ),
    );
  }
}
