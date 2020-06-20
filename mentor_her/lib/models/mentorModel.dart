class Mentor {
  String id;
  String fname;
  String lname;
  String specialisation;
  String imgUrl;
  String email;
  String location;

  Mentor({this.id, this.fname, this.lname, this.specialisation, this.imgUrl, this.email, this.location});

  Mentor.fromMap(Map snapshot, String id) :
      id = id ?? '',
      fname = snapshot['fname'] ?? '',
      lname = snapshot['lastname'] ?? '' ,
      specialisation = snapshot['specialisation'] ?? '',
      location = snapshot['location'] ?? '',
      imgUrl = snapshot['imgUrl'] ?? '';

  toJson() {
    return{
      "fname" : fname,
      "lastname" : lname,
      "specialisation" : specialisation,
      "imgUrl" : imgUrl,
      "email" : email,
      "location" : location,
    };
  }

}