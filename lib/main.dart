import 'package:flutter/material.dart';
import 'package:jsk/Firstpage.dart';
import 'package:jsk/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constent.dart';
import 'home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    title: "Knowledge",
    home: Constants.prefs.getBool("loggedIn") == true ? Home():FirstPage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    routes: {
      "/logout": (context)  => FirstPage(),
      "/login": (context)  => LoginPage(),
      "/home": (context) => Home(),
    },
  ));
}
