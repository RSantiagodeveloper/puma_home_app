import 'package:flutter/material.dart';
import 'package:puma_home/MenuApp.dart';
import 'package:puma_home/addgrupo.dart';
import 'package:puma_home/pantallagrupo.dart';


class MisGruposX extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
}

Widget _grupo(BuildContext context, String nombre) {
  return Card(
    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
    color: Colors.blue,
    child: Column(
      children: <Widget>[
        ListTile(
          leading: IconButton(icon: Icon(Icons.class_), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> PantallaGrupo()));}),
          title:  Text(nombre),
          subtitle: Text("clase virtual"),

        )
      ],
    )
  );
}

class _MisGruposState extends State<MisGruposX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.blue,
          child: Text('Mis Grupos'),
        ),
      ),
      drawer: MenuApp(),
      body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: [
            _grupo(context,"Historia"),
            _grupo(context,"Matematicas"),
            _grupo(context,"Quimica"),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addgrupo()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
