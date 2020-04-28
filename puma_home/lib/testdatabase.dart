
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Testdatabase extends StatefulWidget {
  @override
  _TestdatabaseState createState() => _TestdatabaseState();
}

final baseDeDatos = FirebaseDatabase.instance.reference().child("Prueba");
class _TestdatabaseState extends State<Testdatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Prueba base de datos"),
        
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(

              onPressed:(){
                baseDeDatos.child("elba").set({
                  'elba':"lon",
                  'elmo':"luzco",
                  'pit':"zajot"
                });
              },
            ),
          )
        ],
      ),
    
      
    );
  }
}