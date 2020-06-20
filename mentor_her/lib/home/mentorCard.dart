import 'package:flutter/material.dart';

import '../models/mentorModel.dart';

class MentorCard extends StatefulWidget {
  final Mentor mentor;
  MentorCard({this.mentor});
  @override
  _MentorCardState createState() => _MentorCardState();
}

class _MentorCardState extends State<MentorCard> {
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
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.mentor.imgUrl),
              radius: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.mentor.fname + " " + widget.mentor.lname,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(widget.mentor.specialisation,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ) ,),
                ],
              ),
            )
          ],
        )
    );
  }
}
