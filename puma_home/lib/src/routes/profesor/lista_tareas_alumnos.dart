import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';

class ListaAlumnos extends StatefulWidget {
  final String idUser;
  final String grupoid;
  ListaAlumnos(this.idUser, this.grupoid);
  @override
  _ListaAlumnosState createState() => _ListaAlumnosState(idUser, grupoid);
}

class _ListaAlumnosState extends State<ListaAlumnos> {
  String idUser;
  String grupoid;
  _ListaAlumnosState(this.idUser, this.grupoid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Pantalla Tarea'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      drawer: MenuAppTch(idUser),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Tareas')
              .where("Grupo", isEqualTo: grupoid)
              .where("Status", isEqualTo: 'entregado')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('Nadie ha entregado tareas');
            } else {
              return ListView(
                  children: snapshot.data.documents.map((document) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          leading: Icon(Icons.check_box),
                          title: Text('${document['Id_alumno']}'),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed:(){
                            print('UwU');
                          }
                        )
                      ])),
                    ],
                  ),
                );
              }).toList());
            }
          }),
    );
  }
}
