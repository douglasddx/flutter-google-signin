import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_google_signin/pages/home.page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_google_signin/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final googleSignIn = GoogleSignIn();
  bool busy = false;

  Future login() async {
    setState(() {
      busy = true;
    });

    final user = await googleSignIn.signIn();
    if (user == null) {
      setState(() {
        busy = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Falha no login.'),
        ),
      );
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      MyApp.name = user.displayName;
      MyApp.email = user.email;
      MyApp.photoUrl = user.photoUrl;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${MyApp.name}, seja bem-vindo(a)!'),
          backgroundColor: Colors.blue,
        ),
      );

      setState(() {
        busy = false;
      });

      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 210,
                alignment: Alignment.center,
                child: Text(
                  'Bem-vindo \nao MCODE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(
                horizontal: 60,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: busy
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    )
                  : TextButton(
                      onPressed: () {
                        login();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Logar com o Google',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
