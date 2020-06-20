import 'package:flutter/material.dart';
import 'root_page.dart';
import 'authentication.dart';
//import 'app_loader.dart';

void main() {
  runApp(MyApp());
}


//-----------------------ROOT---------------------------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Have My Back',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.redAccent[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new RootPage(auth: new Auth()));
  }
}












