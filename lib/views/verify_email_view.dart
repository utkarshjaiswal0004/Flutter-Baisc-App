import 'package:flutter/material.dart';
import 'package:login_register/constants/routes.dart';
import 'package:login_register/services/auth/auth_exceptions.dart';
import 'package:login_register/services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';

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
            const Text(
                "We've send you a verification email, please open the link in it to verify your email. (Check spam too)"),
            const Text(
                "If you haven't received any mail, click the button below"),
            TextButton(
              onPressed: () async {
                try {
                  AuthService.firebase().currentUser;
                  await AuthService.firebase().sendEmailVerification();
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    "Some Error Occured",
                  );
                }
              },
              child: const Text('Resend Verification Email'),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                if (!mounted) return;
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
