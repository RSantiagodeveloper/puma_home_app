/*
 * En esta pantalla solo nos encargamos de mostrar el listado de tareas correspondiente
 * al grupo en el que el alumno accedió.
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/routes/alumno/vistaTareaAlumno.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';

class TareasStdn extends StatefulWidget {
  final String idUser;
  final String idGrupo;
  TareasStdn(this.idUser, this.idGrupo);
  @override
  _TareasStdnState createState() => _TareasStdnState(idUser, idGrupo);
}

/// parametro nombre recibe el nombre de la clase

class _TareasStdnState extends State<TareasStdn> {
  final String idUserstate;
  final String idgrupoState;
  _TareasStdnState(this.idUserstate, this.idgrupoState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppStdn(idUserstate),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Listado de Tareas',
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      /**
       * Este Stream Builder es el que se encarga de realizar las consultas al DB Firestore, filtrando
       * las tareas Guardadas en la relacion Ta
       */
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Tareas')
              .where("Id_Grupo", isEqualTo: idgrupoState)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'No hay datos... Esperando',
                style: TextStyle(color: Colors.white),
              );
            } else {
              return new ListView(
                children: snapshot.data.documents.map((document) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(Elementos.contenedor),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 5, color: Color(Elementos.bordes))),
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            //container del icono libro
                            child: Icon(
                              Icons.assignment,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            //container del nombre + ID del grupo
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    document['Nombre'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    document['FechaEntrega'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            //container de los iconos de ver grupo y eliminar grupo
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VistaTareaAlumno(
                                                    idUserstate,
                                                    document.documentID,
                                                    document['Nombre'],
                                                    document['Archivo'],
                                                    document['Descripcion'],
                                                    idgrupoState)));
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }
}
