import 'package:flutter/material.dart';
import 'mentors.dart';
import 'map.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController tabController;
  
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: getTabBar(),
          ),
        ),
        body: getTabBarPages());
    }
  Widget getTabBar() {
    return TabBar(controller: tabController, tabs: [
      Tab(text: "Mentors"),
      Tab(text: "Map")
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      Container(
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Mentors(),
            ],
          ),
      ),
      Container(
        child: Map()
      )
    ]);
  }
}