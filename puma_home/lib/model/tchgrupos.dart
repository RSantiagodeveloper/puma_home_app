import 'package:cloud_firestore/cloud_firestore.dart';

class TchGrupos{
  String _id;
  String _name;

  TchGrupos(this._id, this._name);

  TchGrupos.map(dynamic obj){
    this._id = obj['Id'];
    this._name = obj['Nombre'];
  }

  String get id => _id;
  String get name => _name;

  TchGrupos.fromSnapShot(DocumentSnapshot documentSnapshot){
    Map<String, dynamic> campos = documentSnapshot.data;
    _id = documentSnapshot.documentID;
    _name = campos['Nombre'];
  }

}