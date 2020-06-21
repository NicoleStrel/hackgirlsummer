import 'package:flutter/material.dart';
import 'starting-page/authentication.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'home/home.dart';
import 'info/info.dart';
import 'profile/profile.dart';

//constants
const String page1 = "Awards";
const String page2 = "Home";
const String page3 = "Profile";

class AppLoader extends StatefulWidget {
  AppLoader({Key key, this.auth, this.userId, this.logoutCallback, this.title, this.email}) : super(key: key);
  
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String title;
  final String email;

  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  List<Widget> _pages;
  Widget _page1;
  Widget _page2;
  Widget _page3;

  int _currentIndex;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _page1 = Info();
    _page2 = Home(userId: widget.email);
    _page3 = Profile(userId: widget.email,);

    _pages = [_page1, _page2, _page3];

    _currentIndex = 1;
    _currentPage = _page2;
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => changeTab(index),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.red[400],
          items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconData(59448, fontFamily: 'MaterialIcons')),
                title: Text(page1),
              ),
              BottomNavigationBarItem(
                 icon: Icon(Icons.home),
                title: Text(page2),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(59558, fontFamily: 'MaterialIcons')),
                title: Text(page3),
              ),
            ],
      )
    );
  }
}