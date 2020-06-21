import 'package:flutter/material.dart';
import 'package:havemyback/profile/listCard.dart';


//info
class Award extends StatefulWidget  {
  @override
  _AwardState createState() => _AwardState();
}
class _AwardState extends State<Award> {
  int level=2;
  int xp=30; 
  List<String> awards=['The first step in empowering yourself', 'Cograts! Make some more.', 'Video calling is perfect for networking and advice.', 'More connections will lead you to a better future.'];
  List<String> awardsTitles=['Joined HaveHerBack','First Mentor Connection', 'First Video Call', '5 Mentor Connections!'];
  List <String> urls=["https://picsum.photos/250?image=25", "https://picsum.photos/250?image=152", "https://picsum.photos/250?image=220", "https://picsum.photos/250?image=106"];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
      child:Column(
          children: <Widget>[
            //header
            Container(
              decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20), bottomRight:Radius.circular(20)),
                    
              ),
              height: 300,
              margin: new EdgeInsets.only(bottom: 20),
              padding: new EdgeInsets.only(top:40.0, bottom:10.0, right:40.0, left:40.0),
              alignment: Alignment.center,
              child:Center(
              child:Column(
                children: <Widget>[
                  _level(level),
                  
                  new Text('Achievements',
                      style: new TextStyle(fontSize: 30.0, color: Colors.white)),
                  _xp(xp),
                  _horizontalProgressIndicator(xp),
                  
              ],) 
              ),
            ),
            //list
            _achievmentList(awards, awardsTitles, urls),

          ]
      )
      )
    );
  }


}
//-----------------Progress bar------------------

Widget _horizontalProgressIndicator(int xp){
  final Color backgroundColor=Colors.white;
    return Center(
        child: Column(children: [
          Container(
          padding: EdgeInsets.all(20.0),
          child: LinearProgressIndicator(
            value: xp/100, 
            backgroundColor: backgroundColor,
          )),
        ]
    ));
  
}
//-----------------Progress bar------------------

Widget _xp(int xp){
    return Center(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            new Text(xp.toString(),
                style: new TextStyle(fontSize: 40.0, color: Colors.white)
            ),
            new Text('XP',
                style: new TextStyle(fontSize: 15.0, color: Colors.white)
            ),
          ],
        ),
     );
  
}
//-------------------level-------------------------
Widget _level(level){
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.white,
          size: 100.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Lv",
              style: TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              level.toString(),
              style: TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ]
        ),
        
      ],
    ),
  );
}
//------------------achievement list---------
Widget _achievmentList(List<String> awards, List<String> awardsTitles, List <String> urls){
  return Container(
    height:300,
    child:Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var i=0; i<awards.length; i++)
              ListCard(
                name: awardsTitles[i],
                description: awards[i],
                imageUrl: urls[i],
              )
            ]
          ),

        )
       )
  );
      
}
/*children: <Widget>[
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
              ),
            ],*/