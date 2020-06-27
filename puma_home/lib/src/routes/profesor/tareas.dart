/*
* Pantalla en la 
*/
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/routes/profesor/lista_tareas_alumnos.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/profesor/uptareas_tch.dart';
import 'package:puma_home/src/routes/profesor/datosTareaTch.dart';


class Tareastch extends StatefulWidget {
  final String idUser;
  final String idGrupo;
  Tareastch(this.idUser, this.idGrupo);
  @override
  _TareastchState createState() => _TareastchState(idUser, idGrupo);
}

/// parametro nombre recibe el nombre de la clase

class _TareastchState extends State<Tareastch> {
  final String idUserstate;
  final String idgrupoState;
  _TareastchState(this.idUserstate, this.idgrupoState);

  @override
  void initState() {
    super.initState();
    print('recibi al usuario $idUserstate, $idgrupoState');
  }

  /// funcion vacia que elimina el grupo [idGroup] en firestore
  void deleteTarea(String idTarea) {
    Firestore.instance
        .collection('Tareas')
        .document(idTarea)
        .delete()
        .then((_) {
      statusMessage("La tarea ha sido eliminado");
    });
  }

  ///funcion que lanza un alert dialog con un mensaje que le es dado como parametro
  ///funcion que lanza un alert dialog con un mensaje que le es dado como parametro
  void statusMessage(String mensaje) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(Icons.check, color: Colors.green),
                Text('Completado'),
              ],
            ),
            content: Text(
              mensaje,
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: Colors.blue),
                  ),
                  padding: EdgeInsets.all(1.0),
                  child: Text('Aceptar', style: TextStyle(color: Colors.blue)),
                ),
              )
            ],
          );
        });
  }

  ///widget que muestra un dialogo con un mensaje de advertencia al borrar el Grupo cuya identificacion es [idGroup].
  void _confirmationMessage(String idTarea) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Text('Alerta'),
              ],
            ),
            content: Text(
              'Estas aṕunto de eliminar el grupo.\n Todos los datos se perderan.\n ¿Seguro que deseas continuar?',
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 3, color: Colors.red)),
                      child: GestureDetector(
                        child: Text(
                          'Borrar',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          deleteTarea(
                              idTarea); //funcion que elimina el grupo con el id que lleva como parametro
                        },
                      )),
                  Container(
                      //color: Colors.green,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 3, color: Colors.green),
                      ),
                      child: GestureDetector(
                        child: Text(
                          'Conservar',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ))
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //print('BUILD ID ${usuario.uid} Email ${usuario.email}');
    return Scaffold(
      drawer: MenuAppTch(idUserstate),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Tareas', style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
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
                          flex: 3,
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
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            //container de los iconos de ver grupo y eliminar grupo
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.help,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VistaTareaTch(
                                                idUserstate,document.documentID,document['Tarea'],document['Archivo'],document['Descripcion'],
                                                document['Id_Grupo'],document['FechaEntrega'])));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListaAlumnos(
                                                idUserstate,
                                                document['Id_Grupo'],
                                                document.documentID)));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmationMessage(document.documentID);
                                  },
                                )
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
      bottomNavigationBar: BottomAppBar(
        notchMargin: 2.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 30.0,
          color: Color(Elementos.contenedor),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SubirArchivo(idUserstate,
                      idgrupoState))); //aqui va la llamada a la pantalla formulario_alta_clases
        },
        backgroundColor: Color(Elementos.bordes),
        child: Icon(Icons.add),
      ),
    );
  }
}
