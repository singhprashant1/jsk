import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jsk/loginpage.dart';
import 'package:jsk/register.dart';
import 'constent.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  bool isSignIn = false;

  Future<void> handlessignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      isSignIn = true;
    });
    Navigator.pushReplacementNamed(context, "/home");
  }

  Future<void> googleSignout() async {
    await _auth.signOut().then((onvalue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("ASSETS/index.jpeg"),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 400.0),
            child: Center(
              child: Image(
                image: AssetImage('ASSETS/ps.png'),
                height: 100,
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 270),
            child: Center(
              child: Text(
                "Sign in to your account",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    height: 50,
                    minWidth: 300,
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      "Already a customer? Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    splashColor: Colors.redAccent,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: 300,
                    color: Colors.white70,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      "New to Demo.in? Create an account",
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondScreen()),
                      );
                    },
                    splashColor: Colors.redAccent,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: 300,
                    color: Colors.white70,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      "Google SIgnIN",
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                    onPressed: () {
                      handlessignIn();
                    },
                    splashColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
