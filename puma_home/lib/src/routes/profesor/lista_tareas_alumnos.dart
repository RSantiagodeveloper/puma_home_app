import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/profesor/vistaTarea.dart';

class ListaAlumnos extends StatefulWidget {
  final String idUser;
  final String grupoid;
  final String nombreTarea;
  ListaAlumnos(this.idUser, this.grupoid, this.nombreTarea);
  @override
  _ListaAlumnosState createState() =>
      _ListaAlumnosState(idUser, grupoid, nombreTarea);
}

class _ListaAlumnosState extends State<ListaAlumnos> {
  String idUser;
  String grupoid;
  String nombreTarea;
  _ListaAlumnosState(this.idUser, this.grupoid, this.nombreTarea);

  initState() {
    super.initState();
    print('$idUser, $nombreTarea');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Tareas Entregadas',
            style: TextStyle(color: Color(Elementos.bordes))),
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
              .collection('Tarea_Alumno')
              .where('Id_Tarea', isEqualTo: nombreTarea)
              .where('Status', isEqualTo: 'entregado')
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
                          title: Text('${document['Nombre_Alumno']}'),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VistaTarea(
                                              idUser, document.documentID)));
                                }),
                            (document['Calificado'] == 1)
                                ? Icon(Icons.check_box, color: Colors.green)
                                : Icon(Icons.check_box_outline_blank,
                                    color: Colors.blue[200])
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
