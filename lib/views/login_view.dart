import 'package:flutter/material.dart';
import 'package:login_register/constants/routes.dart';
import 'package:login_register/services/auth/auth_exceptions.dart';
import 'package:login_register/services/auth/auth_service.dart';
import 'package:login_register/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter password here',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  if (!mounted) return;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    homeScreenRoute,
                    (route) => false,
                  );
                } else {
                  if (!mounted) return;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  'user email not found',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  'wrong password',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Authentication Error',
                );
              }
              // catch (e) {
              //   print('Something bad happened');
              //   print(e.runtimeType);
              // print(e.code);
              //   print(e);
              // }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Click here!'),
          )
        ],
      ),
    );
  }
}
