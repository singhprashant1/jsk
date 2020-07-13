import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toast/toast.dart';
import 'loginpage.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  String _email1, _password1, _repassword, _name;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final databaseReference = Firestore.instance;
  void createRecord() async {
    await databaseReference
        .collection("Name")
        .document("1")
        .setData({'name': _name, 'description': 'Programming Guide for Dart'});

    DocumentReference ref = await databaseReference.collection("Name").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
  }

  @override
  void initState() {
    super.initState();
  }

  void _validateInputs() {
    if (_formKey1.currentState.validate()) {
      _formKey1.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey1,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage("ASSETS/index.jpeg"),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 470.0),
              child: Center(
                  child: Text(
                "Register",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
            /*Padding(
              padding: const EdgeInsets.only(bottom: 400.0),
              child: Center(
                child: Image(image: AssetImage('ASSETS/ps.png'),height: 100,
                  width: 200,
                ),
              ),
            ),*/
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (input) {
                          if (input.length < 5) return 'Enter valid name';
                          return null;
                        },
                        onSaved: (String val) {
                          _name = val;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.person),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        onSaved: (String val) {
                          _email1 = val;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _pass,
                        validator: (input) {
                          if (input.length < 8)
                            return 'Empty or less then 8 cher';
                          return null;
                        },
                        onSaved: (input) {
                          _password1 = input;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'ReEnter Password',
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _confirmPass,
                        validator: (val) {
                          if (val != _pass.text) return 'Not Match';
                          return null;
                        },
                        onSaved: (String val) {
                          _repassword = val;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            MaterialButton(
                              height: 50,
                              minWidth: 300,
                              color: Colors.teal,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "Registert",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              onPressed: () {
                                _validateInputs();

                                signUp();
                              },
                              splashColor: Colors.redAccent,
                            ),
                            FlatButton(
                              child: Text(
                                "Already logged In?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (_formKey1.currentState.validate()) {
      _formKey1.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email1, password: _password1))
            .user;
        createRecord();
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        Toast.show("registered", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } catch (e) {
        print(e.message);
        Toast.show(e.message, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regexp = new RegExp(pattern);
  if (!regexp.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
