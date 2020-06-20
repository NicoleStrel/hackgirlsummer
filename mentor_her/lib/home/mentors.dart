import 'package:flutter/material.dart';

class Mentors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: (){
          navigateToSubPage(context);
        },
        child: Text('Find Mentors',style: TextStyle(fontSize: 20 )),
        color: Colors.red,
          textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      ),
    );

  }
  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Subpage()));
  }
}


class Subpage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SubpageState();
  }
}

class _SubpageState extends State<Subpage> {

  String nameCity = "";
  var _currencies = ['Select Category Here','Finance', 'Technology', 'Marketing', 'Human Resources','Entrepreneurship'];
  var _currentItemSelected = 'Select Category Here';

  @override
  Widget build(BuildContext context) {

    debugPrint("Favorite City widget is created");

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
                  debugPrint("set State is called, this tells framework to redraw the Subpage widget");
                  nameCity = userInput;
                });
              },
            ),
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
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}
