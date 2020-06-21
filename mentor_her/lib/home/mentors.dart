import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/home/addMentorCard.dart';
import 'package:havemyback/home/searchMentors.dart';
import 'package:havemyback/models/CRUDModel.dart';
import 'package:havemyback/models/mentorModel.dart';
import 'package:havemyback/models/organisationModel.dart';
import 'package:provider/provider.dart';

import 'mentorCard.dart';

class Mentors extends StatefulWidget {
  final String userId;
  Mentors({this.userId});
  @override
  _MentorsState createState() => _MentorsState();
}

class _MentorsState extends State<Mentors> {

  List<String> mentorIds = [];
  @override
  Widget build(BuildContext context) {
    final mentorProvider = Provider.of<CRUDModel>(context);
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-200,
          child: FutureBuilder(
            future: mentorProvider.fetchOrganisationById(widget.userId),
            builder: (context, AsyncSnapshot<Organisation> snapshot){
              Organisation current = snapshot.data;
              if(snapshot.hasData && (snapshot.data.mentors[0] != "" || snapshot.data.mentors.length > 1)){
                print(snapshot.data.mentors.length);
                return Scaffold(
                  floatingActionButton: FloatingActionButton.extended(onPressed: ()=>navigateToSubPage(context, widget.userId,current), label: Text("Search Mentors"), icon: Icon(Icons.search),),
                  body: ListView.builder(
                      itemCount: snapshot.data.mentors.length,
                      itemBuilder: (buildContext, index) =>
                          FutureBuilder(
                            future: mentorProvider.getMentorById(snapshot.data.mentors[index]),
                            builder: (buildContext, AsyncSnapshot<Mentor> snapshot){
                              if(snapshot.hasData)
                                {
                                  return MentorCard(mentor: snapshot.data);
                                }
                              else{
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          )
                  ),
                );
            } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/undraw_team_spirit_hrr4.png", height: MediaQuery.of(context).size.height/3,),
                    Container(child: Text('You haven’t connected with mentors yet, find one today that helps you grow!'), width: MediaQuery.of(context).size.width-100,),
                    RaisedButton(
                      onPressed: (){
                        navigateToSubPage(context, widget.userId, current);
                      },
                      child: Text('Find Mentors',style: TextStyle(fontSize: 20 )),
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      );
  }
}

Future navigateToSubPage(context,id, current) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchMentors(userId: id, current:current)));
}

