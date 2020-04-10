import 'package:flutter/material.dart';
import 'package:puma_home/MenuApp.dart';
import 'package:puma_home/addgrupo.dart';


class MisGrupos extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
}

Widget _grupo(String nombre) {
  return Card(
    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
    color: Colors.blue,
    child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.class_),
          title:  Text(nombre),
          subtitle: Text("clase virtual"),

        )
      ],
    )
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
      drawer: MenuApp(),
      body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: [
            _grupo("Historia"),
            _grupo("Matematicas"),
            _grupo("Quimica"),
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
