import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/organisationModel.dart';
import 'package:havemyback/profile/listCard.dart';
const String page3 = "Profile";

class CompanyProfile extends StatefulWidget {
  final String id;
  final Organisation org;
  CompanyProfile({this.id, this.org});
  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(child: Icon(Icons.arrow_back_ios), onTap: (){
                      //todo:go back
                      Navigator.pop(context);
                    },),
                  ],
                ),
                SizedBox(height: 25,),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                  maxRadius: 65,
                ),
                SizedBox(height: 15,),
                Text(widget.org.cname,
                    style: TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(height:5),
                Text(widget.org.desc,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ) ,),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6,vertical:2),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red[200],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text(widget.org.category),
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(widget.org.location,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.add), label:Text("Follow")),
                    SizedBox(width: 15,),
                    RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.people), label:Text("Collaborate")),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _tabSection(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _tabSection(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: TabBar(tabs: [
            Tab(text: "Team"),
            Tab(text: "Events"),
          ]),
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height/2.8,
          child: TabBarView(children: [
            Scaffold(
              body: Column(
                children: <Widget>[
                  ListCard(
                    name: "Jane Doe",
                    description: "Founder",
                    imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                  )
                ],
              ),
            ),
            Scaffold(
              body: Text("Events"),
            ),
          ]),
        ),
      ],
    ),
  );
}