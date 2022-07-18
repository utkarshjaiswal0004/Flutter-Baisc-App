// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_register/constants/routes.dart';
import 'package:login_register/views/home_screen.dart';
import 'package:login_register/views/login_view.dart';
import 'package:login_register/views/register_view.dart';
import 'package:login_register/views/verify_email_view.dart';

import 'firebase_options.dart';
// import 'package:flutter_application_1/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "First App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        homeScreenRoute: (context) => const HomeScreen(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const HomeScreen();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            // if (user?.emailVerified ?? false) {
            //   return const Text('Done');
            // } else {
            //   return const VerifyEmailView();
            //   // Navigator.of(context).push(
            //   //   MaterialPageRoute(
            //   //     builder: (context) => const VerifyEmailView(),
            //   //   ),
            //   // );
            // }
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}

// Previous code main starts here

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }

// Previous code main ends here

// class MyApp extends StatelessWidget {
//   const MyApp();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Flutter Demo"),
//         ),
//         // body: Center(
//         //   child: Text('Hello World'),
//         // ),
//         bottomNavigationBar: BottomAppBar(
//             color: Colors.blue,
//             child: IconButton(
//               icon: const Icon(Icons.home),
//               onPressed: () {
//                 print('IconButton');
//               },
//               color: Colors.white,
//             )),
//       ),
//     );
//   }
// }
