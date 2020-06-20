import 'package:flutter/material.dart';

class DropdownFAB extends StatefulWidget {
  final List<String> values;
  final void Function(String) onPressed;
  final String text;
  DropdownFAB({this.values, this.onPressed, this.text});
  @override
  _DropdownFABState createState() => _DropdownFABState();
}

class _DropdownFABState extends State<DropdownFAB> {
  String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.values.elementAt(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 85,
        padding: EdgeInsets.all(8.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(widget.text)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Category"),
                SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_upward),
                  iconSize: 16,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.red,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                    widget.onPressed(dropdownValue);
                  },
                  items : widget.values.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
