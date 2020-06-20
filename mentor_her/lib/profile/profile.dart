import 'package:flutter/material.dart';
const String page3 = "Profile";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(page3),
    );
  }
}
