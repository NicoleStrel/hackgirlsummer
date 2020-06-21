import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/mentorModel.dart';
import 'package:havemyback/models/organisationModel.dart';
import 'package:havemyback/profile/listCard.dart';
const String page3 = "Profile";

class MentorProfile extends StatefulWidget {
  final String id;
  final Mentor mentor;
  MentorProfile({this.id, this.mentor});
  @override
  _MentorProfileState createState() => _MentorProfileState();
}

class _MentorProfileState extends State<MentorProfile> {
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
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.arrow_back_ios , color: Colors.red,),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/250?image=1005'),
                maxRadius: 65,
              ),
              SizedBox(height: 15,),
              Text(widget.mentor.fname,
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Text(widget.mentor.lastname,
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
                child: Text(widget.mentor.specialisation),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_on),
                  Text(widget.mentor.location,
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
            )
          ),
        ),
      ),
    );
  }
}

Widget _tabSectionForMentor(BuildContext context) {
  List<String> experiences=['Mentored kids 8-12', 'March 2008 at the Standford' , 'WordPress site development'];
  List<String> experienceTitles=['STEM mentor', 'Software Analyst Intern', 'Freelancer'];
  String _newExp='';
  String _newExpTitle='';
  final _formKey = GlobalKey<FormState>();

  return DefaultTabController(
    length: 1,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: TabBar(tabs: [
            Tab(text: "Experiences"),
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
//            Scaffold(
//              body: SingleChildScrollView(
//                child: Container(
//                  padding: EdgeInsets.all(16),
//                  margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.all(Radius.circular(20)),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.grey.withOpacity(0.08),
//                        blurRadius: 10,
//                        spreadRadius: 2,
//                        offset: Offset(0, 0),
//                      ),
//                    ],
//                  ),
//                  child:Form(
//                      key: _formKey,
//                      child: Column(
//                        children: [
//                          TextFormField(
//                            maxLines: 1,
//                            keyboardType: TextInputType.text,
//                            decoration: new InputDecoration(
//                              hintText: 'Title',
//                            ),
//                            validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
//                            onSaved: (value) => _newExpTitle=value.trim(),
//                          ),
//                          TextFormField(
//                            maxLines: 1,
//                            keyboardType: TextInputType.text,
//                            decoration: new InputDecoration(
//                              hintText: 'Describe your experience/achievement',
//                            ),
//                            validator: (value) => value.isEmpty ? 'Description can\'t be empty' : null,
//                            onSaved: (value) => _newExp=value.trim(),
//                          ),
//                          Padding(
//                              padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//                              child: SizedBox(
//                                height: 40.0,
//                                child: new RaisedButton(
//                                  elevation: 0.0,
//                                  shape: new RoundedRectangleBorder(
//                                      borderRadius: new BorderRadius.circular(30.0)),
//                                  color: Colors.red[300],
//                                  child: new Text('Submit',
//                                      style: new TextStyle(fontSize: 20.0, color: Colors.white)),
//                                  onPressed:() {
//                                    if (_formKey.currentState.validate()) {
//                                      Scaffold.of(context).showSnackBar(
//                                          new SnackBar(
//                                            content: const Text('Processing Data'),
//                                            backgroundColor: Colors.red[100],
//                                          ));
//                                      experiences.add(_newExp);
//                                      experienceTitles.add(_newExpTitle);
//                                      //will only work if we end up connecting to firebase
//                                    }
//                                  },
//                                ),
//                              )
//                          ),
//                        ],
//                      )
//                  ),
//                ),
//              ),
//            ),
          ]),
        ),
      ],
    ),
  );

}
