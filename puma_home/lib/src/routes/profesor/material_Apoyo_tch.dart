/*
* Pantalla que muestra el material de apoyo de un grupo, da la opcion de subir mas material mediante un boton flotante.
*/
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/profesor/pantalla_Grupo_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:puma_home/src/routes/profesor/formulario_material_apoyo.dart';

class MaterialApoyoTch extends StatefulWidget {
  final String idUser;
  final String idGrupo;
  MaterialApoyoTch(this.idUser, this.idGrupo);
  MaterialApoyoTchState createState() {
    return MaterialApoyoTchState(idUser, idGrupo);
  }
}

class MaterialApoyoTchState extends State<MaterialApoyoTch> {
  String idUserState;
  String idGrupoState;
  MaterialApoyoTchState(this.idUserState, this.idGrupoState);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool activado = false;
  //bool _multiPick = false;
  bool downloading = false; //variables globales
  var progressString = "";

  @override
  void initState() {
    super.initState();
    print('recibi al usuario $idUserState, $idGrupoState');
  }

  Future<void> descargarArchivo(StorageReference ref) async {
    final String url = await ref.getDownloadURL();
    final http.Response downloadData = await http.get(url);
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp.jpg');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    var bodyBytes = downloadData.bodyBytes;
    final String name = await ref.getName();
    final String path = await ref.getPath();
    print(
      'Success!\nDownloaded $name \nUrl: $url'
      '\npath: $path \nBytes Count :: $byteCount',
    );
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Image.memory(
          bodyBytes,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  /// funcion  que elimina el archivo del grupó
  void deleteArchivo(String idArchivo) {
    Firestore.instance
        .collection('Material_Apoyo')
        .document(idArchivo)
        .delete()
        .then((_) {
      statusMessage("El archivo ha sido eliminado");
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
  void confirmationMessage(String idRegArchivos) {
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
              'Estas apunto de eliminar el grupo.\n Todos los datos se perderan.\n ¿Seguro que deseas continuar?',
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
                          deleteArchivo(idRegArchivos); //funcion que elimina el grupo con el id que lleva como parametro
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

//Función para descargar el archivo
  void downloadFile(String url, String name) async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      var download = dio.download(url, "${dir.path}/" + name,
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
      await download;
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
    var path = await getApplicationDocumentsDirectory();
    print("${path.path}/");
  }
 
  Widget loadBar() {
    return Center(
      child: downloading
          ? Container(
              height: 120.0,
              width: 200.0,
              child: Card(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Downloading File: $progressString",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Text("No Data"),
    );
  }

  ///
  Widget createMenuButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 40),
        child: RaisedButton(
          textColor: Colors.black,
          child: Text('Pantalla Grupo'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PantallaGrupoTch(idUserState,idGrupoState," ")));
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    //print('BUILD ID ${usuario.uid} Email ${usuario.email}');
    return Scaffold(
      drawer: MenuAppTch(idUserState),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Material de apoyo',
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
              .collection('Material_Apoyo')
              .where("Id_Grupo", isEqualTo: idGrupoState)
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
                        loadBar(),
                        Expanded(
                          child: Container(
                            //contiene del nombre Archivo
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    document['Descripcion'],
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
                            //Descargar archivos
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.file_download,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    downloadFile(document['Archivo'],document['Material_Apoyo']);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    confirmationMessage(document.documentID);
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
                  builder: (context) =>
                      MaterialApoyoFormTch(idUserState,idGrupoState))); //aqui va la llamada al formulario para subir archivos
        },
        backgroundColor: Color(Elementos.bordes),
        child: Icon(Icons.add),
      ),
    );
  }

}