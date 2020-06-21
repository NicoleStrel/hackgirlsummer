import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/CRUDModel.dart';
import 'package:havemyback/models/mentorModel.dart';
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
    final collectionProvider = Provider.of<CRUDModel>(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child:FutureBuilder<bool>(
          future: collectionProvider.determineIfMentor((widget.userId)),
          builder: (context, snapshot) {
            print(snapshot.data);
            if(snapshot.hasData){
              return Center(
                child: snapshot.data ? _mentorPersonal(context): _orgPersonal(context),
              );
            }
            else return CircularProgressIndicator();
          }
        ),
      )
    );
  }
  //child: global.isMentor? _mentorPersonal(context): _orgPersonal(context),

  //---------------------------Organization Profile--------------------------
  Widget _orgPersonal(BuildContext context) {
    final profileProvider = Provider.of<CRUDModel>(context);
    return FutureBuilder<Organisation>(
      future: profileProvider.fetchOrganisationById(widget.userId),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height:16,
              ),
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
                  _tabSectionForOrg(context),
                ],
              )
            ],
          );
        }
        else return CircularProgressIndicator();
      }
    );
  }
  //---------------------------Mentor Profile--------------------------
  Widget _mentorPersonal(BuildContext context) {
    final profileProvider = Provider.of<CRUDModel>(context);
    return FutureBuilder<Mentor>(
      future: profileProvider.getMentorById(widget.userId),
      builder: (context, snapshot) {
        print(snapshot.data);
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
                backgroundImage: NetworkImage('https://picsum.photos/250?image=1005'),
                maxRadius: 65,
              ),
              SizedBox(height: 15,),
              Text(snapshot.data.fname,
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Text(snapshot.data.lastname,
                  style: TextStyle(
                    fontSize: 18,
              )),
              SizedBox(height:5),
              Text('Mentor',
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
                child: Text(snapshot.data.specialisation),
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
              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  _tabSectionForMentor(context), //to complex to add futurebuilder here for experiences
                ],
              )
            ],
          );
        }
        else return CircularProgressIndicator();
      }
    );
  }
}


Widget _tabSectionForOrg(BuildContext context) {
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
          height: MediaQuery.of(context).size.height/2.6,
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

Widget _tabSectionForMentor(BuildContext context) {
  List<String> experiences=['Mentored kids 8-12', 'March 2008 at the Standford' , 'WordPress site development'];
  List<String> experienceTitles=['STEM mentor', 'Software Analyst Intern', 'Freelancer'];
  String _newExp='';
  String _newExpTitle='';
  final _formKey = GlobalKey<FormState>();

  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: TabBar(tabs: [
            Tab(text: "Experiences"),
            Tab(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.edit),
                    Text("Add New"),
                  ]
                )
            ),
          ]),
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height/2.6,
          child: TabBarView(children: [
            Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                     for (var i=0; i<experiences.length; i++)
                      ListCard(
                        name: experienceTitles[i],
                        description: experiences[i],
                        imageUrl: "https://www.iconspng.com/images/female-avatar-3/female-avatar-3.jpg",
                      ),
                  ],
                ),
              ),
            ),
            Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child:Form(
                    key: _formKey,
                    child: Column(
                       children: [
                        TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                                hintText: 'Title',
                                ),
                            validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
                            onSaved: (value) => _newExpTitle=value.trim(),
                          ),
                          TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                                hintText: 'Describe your experience/achievement',
                                ),
                            validator: (value) => value.isEmpty ? 'Description can\'t be empty' : null,
                            onSaved: (value) => _newExp=value.trim(),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                            child: SizedBox(
                              height: 40.0,
                              child: new RaisedButton(
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0)),
                                color: Colors.red[300],
                                child: new Text('Submit',
                                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                                onPressed:() {
                                  if (_formKey.currentState.validate()) {
                                    Scaffold.of(context).showSnackBar(
                                      new SnackBar(
                                          content: const Text('Processing Data'),
                                          backgroundColor: Colors.red[100],
                                    ));
                                    experiences.add(_newExp);
                                    experienceTitles.add(_newExpTitle);
                                    //will only work if we end up connecting to firebase
                                  }
                                }, 
                              ),
                            )
                          ),
                       ],
                    )
                  ),
                ),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
  
}






                        