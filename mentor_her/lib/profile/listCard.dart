import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String description;

  ListCard({this.imageUrl, this.name, this.description});
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
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
              backgroundImage: NetworkImage(widget.imageUrl),
              radius: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(widget.description,
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
