import 'package:flutter/material.dart';
import 'package:flutter_google_signin/pages/login.page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google Sign';
  static String name;
  static String email;
  static String photoUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: LoginPage());
  }
}
