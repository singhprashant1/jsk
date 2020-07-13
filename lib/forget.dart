import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';


class Forget extends StatefulWidget {
  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget>with SingleTickerProviderStateMixin {
  String _email2;
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void _validateInputs() {
    if (_formKey2.currentState.validate()) {
      _formKey2.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey2,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage("ASSETS/index.jpeg"),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 400.0),
              child: Center(child: Text("Reset Password", style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),)),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                        hintText: 'Enter email',
                        prefixIcon: Icon(Icons.person),
                        contentPadding:
                        const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      onSaved: (String val) {
                        _email2 = val;
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
                            child: Text("Forget password", style: TextStyle(
                                color: Colors.white, fontSize: 20.0),),
                            onPressed: () {
                              _validateInputs();
                              sendPasswordResetEmail(_email2);
                              },
                            splashColor: Colors.redAccent,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }



  void sendPasswordResetEmail(String email) async {
    final formState =  _formKey2.currentState;
    if(formState.validate()) {
      formState.save();
      try{
        final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
        await _firebaseAuth.sendPasswordResetEmail(email: _email2);
        Navigator.pushReplacementNamed(context, "/login");
        Toast.show("link sent", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }catch(e){
        print(e.message);
        Toast.show(e.message, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }
}
  String validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regexp = new RegExp(pattern);
    if (!regexp.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

