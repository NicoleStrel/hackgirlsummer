import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/CRUDModel.dart';
import 'package:havemyback/models/organisationModel.dart';
import 'package:havemyback/profile/listCard.dart';
import 'package:provider/provider.dart';
const String page3 = "Profile";

class Profile extends StatefulWidget {
  final String userId;
  Profile({this.userId});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<CRUDModel>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder<Organisation>(
            future: profileProvider.fetchOrganisationById(widget.userId),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.edit , color: Colors.red,),
                      ],
                    ),
                    SizedBox(height: 25,),
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                      maxRadius: 65,
                    ),
                    SizedBox(height: 15,),
                    Text(snapshot.data.cname,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    SizedBox(height:5),
                    Text(snapshot.data.desc,
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
                      child: Text(snapshot.data.category),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text(snapshot.data.location,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: <Widget>[
                        _tabSection(context),
                      ],
                    )
                  ],
                );
              }
              else return CircularProgressIndicator();
            }
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
          height: MediaQuery.of(context).size.height/3.5,
          child: TabBarView(children: [
            Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListCard(
                      name: "Jane Doe",
                      description: "Founder",
                      imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                    ),
                    ListCard(
                      name: "John Doe",
                      description: "Manager",
                      imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                    ),
                    ListCard(
                      name: "John Doe",
                      description: "Manager",
                      imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                    ),
                    ListCard(
                      name: "John Doe",
                      description: "Manager",
                      imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.group_add, color: Colors.white,),
              ),
            ),
            Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListCard(
                      name: "Event A",
                      description: "Workshop for xyz stuff ",
                      imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                    ),
                    ListCard(
                      name: "Event B",
                      description: "Talk at local community event",
                      imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add_to_photos, color: Colors.white,),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}