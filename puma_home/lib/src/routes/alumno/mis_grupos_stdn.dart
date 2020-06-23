/*
* Pantalla que muestra los grupos a los que el alumno esta inscrito y da la opcion de poder inscribirse a otro mediante un boton flotante.
* 
*/
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/routes/alumno/pantalla_Grupo_stdn.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/routes/alumno/alta_Grupo.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';

class MisGruposStdn extends StatefulWidget {
  final String idUser;
  MisGruposStdn(this.idUser);
  @override
  _MisGruposState createState() => _MisGruposState(idUser);
}

class _MisGruposState extends State<MisGruposStdn> {
  final String idUserstate;
  _MisGruposState(this.idUserstate);
  String nombreClass = '';

  @override
  void initState() {
    super.initState();
    print('recibi al usuario $idUserstate');
  }

  /// funcion vacia que elimina el grupo [idGroup] en firestore
  void deleteGroup(String idGroup) {
    Firestore.instance
        .collection('Grupo_Alumno')
        .document(idGroup)
        .delete()
        .then((_) {
      statusMessage("El grupo ha sido eliminado");
    });
  }

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
  void _confirmationMessage(String idGroup) {
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
                          deleteGroup(
                              idGroup); //funcion que elimina el grupo con el id que lleva como parametro
                        },
                      )),
                  Container(
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
      drawer: MenuAppStdn(idUserstate),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Mis Grupos',
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Grupo_Alumno')
              .where("Alumno_id", isEqualTo: idUserstate)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'No estas inscrito a ningun grupo...Aun...',
                style: TextStyle(color: Colors.redAccent),
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
                          child: Container(
                            //container del icono libro
                            child: Icon(
                              Icons.book,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            //container del nombre + ID del grupo
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${document['NombreGrupo']}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
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
                                    //ver grupo
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PantallaGrupoS(
                                                    idUserstate,
                                                    document['Grupo_id'],
                                                    document['Profesor_Id'],
                                                    document['NombreGrupo'])));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    //eliminar grupo
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
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AltaClase(
                      idUserstate))); //aqui va la llamada a la pantalla formulario_alta_clases
        },
        backgroundColor: Color(Elementos.bordes),
        child: Icon(Icons.add),
      ),
    );
  }
}
