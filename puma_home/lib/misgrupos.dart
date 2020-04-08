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
           _grupo("Historia"),
           _grupo("Matematicas"),
           _grupo("Quimica"),
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