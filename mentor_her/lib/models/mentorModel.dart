class Mentor {
  String id;
  String fname;
  String lastname;
  String specialisation;
  String imgUrl;
  String email;
  String location;
//  List<String> organisations;

  Mentor({this.id, this.fname, this.lastname, this.specialisation, this.imgUrl, this.email, this.location});

  Mentor.fromMap(Map snapshot, String id) :
      id = id ?? '',
      fname = snapshot['fname'] ?? '',
      lastname = snapshot['lastname'] ?? '' ,
      specialisation = snapshot['specialisation'] ?? '',
      location = snapshot['location'] ?? '',
//      organisations = List.from(snapshot['organisations']) ?? [],
      imgUrl = snapshot['imgUrl'] ?? '';

  toJson() {
    return{
      "fname" : fname,
      "lastname" : lastname,
      "specialisation" : specialisation,
      "email" : email,
      "location" : location,
//      "organisations" : organisations,
      "imgUrl": "",
    };
  }

}