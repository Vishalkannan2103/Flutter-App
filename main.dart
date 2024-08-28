import 'package:app/login.dart';
import 'package:app/registration.dart';
// import 'package:app/registration.dart';
import 'package:flutter/material.dart';
// import 'package:app/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(title: 'Source'),
      routes: {
        '/login': (context) => LoginPage(
              title: 'LoginPge',
            ),
        '/Reigister': (context) => RegistrationPage(title: 'RegistrationPage')
      },
    );
  }
}
