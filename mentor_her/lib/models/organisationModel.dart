import 'mentorModel.dart';

class Organisation {
  String id;
  String cname;
  String category;
  String desc;
  String imgUrl;
  String email;
  String location;
  List<Mentor> mentors;

  Organisation({this.id, this.cname, this.category, this.desc, this.imgUrl, this.email, this.location, this.mentors});

  Organisation.fromMap(Map snapshot, String id) :
      id = id ?? '',
      cname = snapshot['Cname'] ?? '',
      category = snapshot['category'] ?? '',
      desc = snapshot['desc'] ?? '',
      email = snapshot['email'] ?? '',
      location = snapshot['location'] ?? '',
      imgUrl = snapshot['imgUrl'] ?? '';

  toJson() {
    return{
      "Cname" : cname,
      "category" : category,
      "imgUrl" : imgUrl,
      "email" : email,
      "location" : location,
      "desc" : desc,
    };
  }

}