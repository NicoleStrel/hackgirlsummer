import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/mentorModel.dart';
import 'package:havemyback/models/organisationModel.dart';
import '../locator.dart';

import '../api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Mentor> mentors;
  List<Organisation> organisations;
  List<Mentor> organisationMentors;
  Organisation organisation;

  Future<List<Mentor>> fetchMentors() async {
    var result = await _api.getDataCollection('mentors');
    mentors = result.documents
        .map((doc) => Mentor.fromMap(doc.data, doc.documentID))
        .toList();
    return mentors;
  }

  Stream<QuerySnapshot> fetchMentorsAsStream() {
    return _api.streamDataCollection('mentors');
  }

  Future<Mentor> getMentorById(String id) async {
    var doc = await _api.getDocumentById('mentors',id);
    return  Mentor.fromMap(doc.data, doc.documentID) ;
  }


  Future removeMentor(String id) async{
    await _api.removeDocument('mentors', id) ;
    return ;
  }
  Future updateMentor(Mentor data,String id) async{
    await _api.updateDocument('mentors', data.toJson(), id) ;
    return ;
  }

  Future addMentor(Mentor data) async{
    var result  = await _api.addDocument('mentors' , data.toJson()) ;
    return ;

  }

  Future<List<Organisation>> fetchOrganisations() async {
    var result = await _api.getDataCollection('organisations');
    organisations = result.documents
        .map((doc) => Organisation.fromMap(doc.data, doc.documentID))
        .toList();
    return organisations;
  }


  Future<Organisation> fetchOrganisation(String id) async {
    var result = await _api.getDocumentById('organisations',id);
    return Organisation.fromMap(result.data, result.documentID);
  }

  


}