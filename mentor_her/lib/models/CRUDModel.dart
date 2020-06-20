import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/mentorModel.dart';
import 'locator.dart';

import 'api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Mentor> mentors;


  Future<List<Mentor>> fetchMentors() async {
    var result = await _api.getDataCollection();
    mentors = result.documents
        .map((doc) => Mentor.fromMap(doc.data, doc.documentID))
        .toList();
    return mentors;
  }

  Stream<QuerySnapshot> fetchMentorsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Mentor> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Mentor.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Mentor data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Mentor data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }


}