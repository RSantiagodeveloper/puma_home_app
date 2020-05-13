import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/routes/profesor/pantalla_Grupo_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

class MisGruposTch extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
}

Widget _grupo(BuildContext context, String nombre) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Color(Elementos.contenedor),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: IconButton(
                icon: Icon(Icons.class_),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PantallaGrupoTch('userX', 'grpY')));
                }),
            title: Text(nombre),
            subtitle: Text("clase virtual"),
          )
        ],
      ));
}

class _MisGruposState extends State<MisGruposTch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Color(Elementos.contenedor),
          child: Text('Mis Grupos'),
        ),
      ),
      drawer: MenuAppTch(),
      body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: [
            _grupo(context, "Historia"),
            _grupo(context, "Matematicas"),
            _grupo(context, "Quimica"),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Color(Elementos.contenedor),
        child: Icon(Icons.add),
      ),
    );
  }
}
