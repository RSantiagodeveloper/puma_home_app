import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/routes/profesor/pantalla_Grupo_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/routes/profesor/formulario_alta_clases.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';

class MisGruposTch extends StatefulWidget {
  final String idUser;
  MisGruposTch(this.idUser);
  @override
  _MisGruposState createState() => _MisGruposState(idUser);
}

/// widget que devuelve una tarjeta. Esta contiene la informacion de un grupo
/// parametro nombre recibe el nombre de la clase

class _MisGruposState extends State<MisGruposTch> {
  final String idUserstate;
  _MisGruposState(this.idUserstate);

  @override
  void initState() {
    super.initState();
    print('recibi al usuario $idUserstate');
  }

  /* Future<void> listGrup(String iduser) async {
    Map<String, dynamic> valor;
    var data = await fireReference.collection('Mis').where("idteacher",isEqualTo:iduser).getDocuments().then((value){
      value.documents.forEach((result){
            valor = result.data;
             grupos.add(valor['NombreClase']);
       });
    });
  } */
  /* TODO: arreglar el delete
  Future<void> DelateGroup(String iduser, String nombreMat) async {
    var erase = await fireReference.collection('MisGrupos').where("idteacher",isEqualTo:iduser).where("nombreClase",isEqualTo:nombreMat).delete();
  
  //delete
  agregar el boton para delete
  void delete_group(String iduser, String nombreMat, int position) async{
    await fireReference.child(iduser).remove().then((_){
      setState(){
      //aquí estaria el quitar el boton del grupo
      //en el then, donde se esta seleccionando(position), ese es el que se elimina
    }
  });
  //
  }
 */
  void deleteGroup(String idGroup){
   
    Firestore.instance.collection('Grupo').document(idGroup).delete().then((_) => {
      statusMessage("El grupo ha sido eliminado")
    });
  }
  ///funcion que lanza un alert dialog con un mensaje que le es dado como parametro
  void statusMessage(String mensaje){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Noticia'),
            content: Text(
              mensaje,
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: GestureDetector(
                    child: Text(
                      'Aceptar',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
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

///widget que muestra un dialogo con un mensaje de advertencia al borrar el Grupo cuya identificacion es [idGroup].
  void _confirmationMessage(String idGroup) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alerta'),
            content: Text(
              'Estas aṕunto de eliminar el grupo.\n Todos los datos se perderan.\n ¿Seguro que deseas continuar?',
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: GestureDetector(
                    child: Text(
                      'Borrar',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      deleteGroup(idGroup); //funcion que elimina el grupo con el id que lleva como parametro                     
                    },
                  )),
                  Container(
                    color: Colors.green,
                    child: GestureDetector(
                    child: Text(
                      'Conservar',
                      style: TextStyle(fontSize: 14, color: Colors.white),
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
      drawer: MenuAppTch(),
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
          stream: Firestore.instance.collection('Grupo').where("Clave_Profesor", isEqualTo: idUserstate).snapshots(),
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
                    width: MediaQuery.of(context).size.width / 1.25,
                    height: MediaQuery.of(context).size.height / 6.6667,
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
                        Container(
                          width: MediaQuery.of(context).size.width / 6.667,
                          //height: MediaQuery.of(context).size.height / 6.6667,
                          child: Icon(
                            Icons.book,
                            size: MediaQuery.of(context).size.height / 13.3333,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          //width: MediaQuery.of(context).size.width / 1.5625,
                          width: MediaQuery.of(context).size.width / 1.81,
                          //height: MediaQuery.of(context).size.height / 6.6667,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  document['Nombre'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  document.documentID,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )
                              ]),
                        ), //end container
                        Container(
                          width: MediaQuery.of(context).size.width / 3.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                size: MediaQuery.of(context).size.height /
                                    26.666666,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaGrupoTch(
                                                'userX', 'grpY')));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: MediaQuery.of(context).size.height /
                                    26.666666,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _confirmationMessage(document.documentID);
                              },
                            )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FormularioAltaClase())); //aqui va la llamada a la pantalla formulario_alta_clases
        },
        backgroundColor: Color(Elementos.contenedor),
        child: Icon(Icons.add),
      ),
    );
  }
}


/*
     ButtonBar(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                size: MediaQuery.of(context).size.height /
                                    26.666666,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaGrupoTch(
                                                'userX', 'grpY')));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: MediaQuery.of(context).size.height /
                                    26.666666,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _confirmationMassage();
                              },
                            )
                          ],
                        ),//end buttonbar                   
*/ 