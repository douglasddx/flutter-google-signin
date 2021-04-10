import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();

    void logout() async {
      if (!FirebaseAuth.instance.currentUser.isAnonymous) {
        await googleSignIn.disconnect();
        await googleSignIn.currentUser.clearAuthCache();
        FirebaseAuth.instance.signOut();
      }
      Navigator.pop(context);
    }

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Spacer(),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  150,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  MyApp.photoUrl,
                ),
                maxRadius: 100,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '${MyApp.name}',
              style: TextStyle(
                color: Colors.deepPurple[900],
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${MyApp.email}',
              style: TextStyle(
                color: Colors.deepPurple[700],
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 5),
            TextButton(
              onPressed: () {
                logout();
              },
              child: Text(
                'Sair',
                style: TextStyle(
                  color: Colors.lightBlue[900],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
