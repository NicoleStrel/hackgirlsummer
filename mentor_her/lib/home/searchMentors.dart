import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/home/mentorCard.dart';
import 'package:havemyback/models/CRUDModel.dart';
import 'package:havemyback/models/mentorModel.dart';
import 'package:provider/provider.dart';

class SearchMentors extends StatefulWidget {
  @override
  _SearchMentorsState createState() => _SearchMentorsState();
}

class _SearchMentorsState extends State<SearchMentors> {

  String nameCity = "";
  var _currencies = ['Finance', 'Technology', 'Marketing', 'Human Resources','Entrepreneurship'];
  var _currentItemSelected = 'Finance';
  List<Mentor> mentors;

  @override
  Widget build(BuildContext context) {

    final mentorProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: const Text('Add Mentors', style: TextStyle(
            color: Colors.white
        )),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String userInput) {
                setState(() {
                  nameCity = userInput;
                });
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Specialisation:'),
                SizedBox(width: 10,),
                DropdownButton<String>(
                  items: _currencies.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  onChanged: (String newValueSelected) {
                    // Your code to execute, when a menu item is selected from drop down
                    _onDropDownItemSelected(newValueSelected);
                  },

                  value: _currentItemSelected,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height-300,
                child: FutureBuilder(
                    future: mentorProvider.fetchMentorsBySpecialisation(_currentItemSelected),
                    builder: (context, AsyncSnapshot<List<Mentor>> snapshot) {
                      print("Snapshot");
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        mentors = snapshot.data;
                        return ListView.builder(
                          itemCount: mentors.length,
                          itemBuilder: (buildContext, index) =>
                              MentorCard(mentor: mentors[index]),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}


