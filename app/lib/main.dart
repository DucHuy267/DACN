import 'package:flutter/material.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/screens/root_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
