import 'package:flutter/material.dart';

class MisGrupos extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
  
}
Widget _grupo(String nombre){
  return Card(
      color: Colors.lightBlue,
      child: Text(nombre),
  );
}
class _MisGruposState extends State<MisGrupos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.blue,
          child: Text('Mis Grupos'),
        ),
      ),
      drawer: new Drawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal:16,
          vertical:16,
        ),
        children:[
           _grupo("rimjobs"),
           _grupo("fisting"),
           _grupo("Diana va a ser mi puta")
        ]

      ),
     floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}