import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                    print('Inside email send code');
                  } catch (e) {
                    print('Error occured with code');
                    print(e);
                  }
                },
                child: const Text('Send Verification Email'))
          ],
        ),
      ),
    );
  }
}
