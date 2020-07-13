import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jsk/loginpage.dart';
import 'constent.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  bool isSignIn = false;

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("firestore"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Constants.prefs.setBool("loggedIn", false);
                googleSignout();
                Navigator.pushReplacementNamed(context, "/logout");
              }),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("ASSETS/index.jpeg"),
            fit: BoxFit.cover,
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
//            DrawerHeader(
//                child: Text("hi i am drawer",style: TextStyle(color: Colors.white),
//                ),
//              decoration: BoxDecoration(color: Colors.purpleAccent),
//            ),
        UserAccountsDrawerHeader(
          accountName: Text("prashant"),
          accountEmail: Text("prashantsingh@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage("ASSETS/index.jpeg"),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Account"),
          subtitle: Text("personal"),
          trailing: Icon(Icons.edit),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text("rajan@gmail.com"),
          trailing: Icon(Icons.send),
        ),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              Constants.prefs.setBool("loggedIn", false);
              googleSignout();
              Navigator.pushReplacementNamed(context, "/logout");
            }),
      ])),
    );
  }
}
