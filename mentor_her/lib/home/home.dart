import 'package:flutter/material.dart';
import 'package:havemyback/models/CRUDModel.dart';
import 'package:provider/provider.dart';
import 'mentors.dart';
import 'map.dart';

class Home extends StatefulWidget {
  final String userId;
  Home({this.userId});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController tabController;
  bool mentorPage;
  @override
  void initState() {
    super.initState();
    mentorPage = false;
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
      Tab(text: mentorPage ? "Organisation": "Mentors"),
      Tab(text: "Map")
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      Container(
        child: Center(
            child: Padding(
            padding: EdgeInsets.all(16.0),
        child:FutureBuilder<bool>(
        future: Provider.of<CRUDModel>(context).determineIfMentor((widget.userId)),
        builder: (context, snapshot) {
        if(snapshot.hasData){
        return Center(
        child: snapshot.data ? 
            Center(
              child: Column(
                children: <Widget>[
                  new Image.asset("asset/undraw_remote_team_h93l.png", height: 200),
                  Text('Search for Organisations to Mentor!'),
                  RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
                    },
                    child: Text('Search Organisations',style: TextStyle(fontSize: 20 )),
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Mentors(userId: widget.userId),
          ],
        ),
        );
        }
        else return CircularProgressIndicator();
        }
        ),
        )
        )
      ),
      Container(
        child: Map()
      )
    ]);
  }
}

