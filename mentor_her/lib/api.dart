import 'package:cloud_firestore/cloud_firestore.dart';

class Api{
  final Firestore _db = Firestore.instance;
//  final String path;
//  CollectionReference ref;

//  Api( this.path ) {
//    ref = _db.collection(path);
//  }

  Future<QuerySnapshot> getDataCollection(String path) {
    return _db.collection(path).getDocuments() ;
  }
  Future<QuerySnapshot> getDataByEqualQuery(String path, String field, String value) {
    return _db.collection(path).where(field, isEqualTo: value).getDocuments();
  }
  Stream<QuerySnapshot> streamDataCollection(String path) {
    return _db.collection(path).snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String path, String id) {
    return _db.collection(path).document(id).get();
  }
  Future<void> removeDocument(String path, String id){
    return _db.collection(path).document(id).delete();
  }
  Future<DocumentReference> addDocument(String path, Map data) {
    return _db.collection(path).add(data);
  }
  Future<void> updateDocument(String path, Map data , String id) {
    return _db.collection(path).document(id).updateData(data) ;
  }


}
