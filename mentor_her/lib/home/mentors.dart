import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/mentorModel.dart';
import 'package:havemyback/profile/listCard.dart';
import 'package:provider/provider.dart';

import '../CRUDModel.dart';

class Mentors extends StatefulWidget {
  @override
  _MentorsState createState() => _MentorsState();
}

class _MentorsState extends State<Mentors> {

  List<Mentor> mentors;
  @override
  Widget build(BuildContext context) {
    final mentorProvider = Provider.of<CRUDModel>(context);

    return Container(
        child: StreamBuilder(
            stream: mentorProvider.fetchMentorsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                mentors = snapshot.data.documents
                    .map((doc) => Mentor.fromMap(doc.data, doc.documentID))
                    .toList();
                return ListView.builder(
                  itemCount: mentors.length,
                  itemBuilder: (buildContext, index) =>
                      ListCard(name:mentors[index].fname + mentors[index].lname, description:mentors[index].specialisation, imageUrl: mentors[index].imgUrl,),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      );
  }
}
