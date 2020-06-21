import 'package:flutter/material.dart';
import 'package:havemyback/models/CRUDModel.dart';
import 'package:havemyback/models/organisationModel.dart';
import 'package:havemyback/profile/MentorProfile.dart';
import 'package:provider/provider.dart';

import '../models/mentorModel.dart';

class AddMentorCard extends StatefulWidget {
  final Mentor mentor;
  final String userId;
  final Organisation current;
  AddMentorCard({this.mentor, this.userId, this.current});
  @override
  _AddMentorCardState createState() => _AddMentorCardState();
}

class _AddMentorCardState extends State<AddMentorCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(left: 16, top: 8, right: 8, bottom:8),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.mentor.imgUrl),
              radius: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MentorProfile(id:widget.userId, mentor:widget.mentor)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.mentor.fname + " " + widget.mentor.lastname,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(widget.mentor.location,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      ) ,),
                  ],
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () async {
                //TODO: Add updateOrganisation function to add Mentor
                bool exists = false;
                for(String id in widget.current.mentors){
                  if (id == widget.mentor.id) {
                    exists = true;
                  }
                }
                if(!exists) widget.current.mentors.add(widget.mentor.id);
                await Provider.of<CRUDModel>(context).updateOrganisation(widget.current, widget.userId);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: exists ? Text("Mentor already exists") : Text('Mentor Request Sent'),
                  duration: Duration(seconds: 3),
                ));
              },
              elevation: 2.0,
              fillColor: Colors.red[200],
              child: Icon(
                Icons.add,
                size: 15.0,
              ),
              padding: EdgeInsets.all(8.0),
              shape: CircleBorder(),
            )
          ],
        )
    );
  }
}
