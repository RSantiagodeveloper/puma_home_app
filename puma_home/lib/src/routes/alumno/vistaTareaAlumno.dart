/*
 * Pantalla en la que el alumno puede ver la tarea que el profe le dejó,
 * subir su tarea, y visualizar su calificación
 */
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/routes/alumno/Vista_Calificaciones.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart'; //import del PlatformException


class VistaTareaAlumno extends StatefulWidget {
  final String idUser;
  final String idTarea;
  final String urlFile;
  final String descTarea;
  final String nombreTarea;
  final String idGrupo;
  VistaTareaAlumno(this.idUser, this.idTarea, this.nombreTarea, this.urlFile,
      this.descTarea, this.idGrupo);
  @override
  _VistaTareaState createState() => _VistaTareaState(
      idUser, idTarea, nombreTarea, urlFile, descTarea, idGrupo);
}

class _VistaTareaState extends State<VistaTareaAlumno> {
  String idUser;
  String idTarea;
  String urlFile;
  String descTarea;
  String nombreTarea;
  String idGrupo;
  _VistaTareaState(this.idUser, this.idTarea, this.nombreTarea, this.urlFile,
      this.descTarea, this.idGrupo);

  TextEditingController comentarioAlumno = TextEditingController();
  List<StorageUploadTask> _task = <StorageUploadTask>[];
  String _path;
  String nombreBoton = 'Buscar archivo';
  String fileName = 'nombre de archivo esta vacio';
  String _extension;
  FileType _pickType;
  String nombreBotonSubir = 'Seleccionar archivo';
  bool downloading = false;
  var progressString = "";


  void initState() {
    super.initState();
    print('$idUser $idTarea $nombreTarea $urlFile $descTarea $idGrupo');
  }


  Future<String> obtenerLinkArchivo() async{
    StorageReference ref =FirebaseStorage.instance.ref().child(idGrupo + "/" + fileName);
    var url = await ref.getDownloadURL();
    String link = url.toString();
    print("enlace del archivo de la tarea: "+link);
    return link;
  }

//Función que envia la tarea, recuperando el id del alumno y el id de la tarea
  void enviarTarea(String idUser, String idTarea, String comentario,
      String idGrupo, String urlFileAlum) {
    Firestore.instance
        .collection('Tarea_Alumno')
        .where('Id_Alumno', isEqualTo: idUser)
        .where('Id_Tarea', isEqualTo: idTarea)
        .getDocuments()
        .then((value) {
      if (value.documents.isEmpty) {
        //Si no ha subido nada el alumno, se crea un nuevo documento y ahi se guarda la información
        Firestore.instance
            .collection('Usuarios')
            .document(idUser)
            .get()
            .then((value) {
          Map<String, dynamic> datos = value.data;
          String nombreAlumno =
              '${datos['UsrName']}';
          Firestore.instance.collection('Tarea_Alumno').add({
            //se agrega el arhivo del alumno y comentario si agregó algo
            //Por default se llenan los campos de usuario, grupo y tarea
            'Archivo': urlFileAlum, 
            'Calificacion': 0.0,
            'Calificado': 0,
            'Comentario': comentario,
            'Comentario_Profe': '',
            'Id_Alumno': idUser,
            'Id_Grupo': idGrupo,
            'Id_Tarea': idTarea,
            'Nombre_Alumno': nombreAlumno,
            'Status': 'entregado' //cuando se envia la tarea, cambia el status automáticamente a entregado
          }).then((value){
            statusMessage('Has enviado tu tarea');
          });
        });
      } else {
        //Si ya existía un documento, entonces se actualizan los campos que el alumno decida
        Firestore.instance
            .collection('Usuarios')
            .document(idUser)
            .get()
            .then((valueusr) {
          Map<String, dynamic> datos = valueusr.data;
          String nombreAlumno =
              '${datos['UsrName']}';
          Firestore.instance
              .collection('Tarea_Alumno')
              .document(value.documents[0].documentID)
              .updateData({
            'Archivo': urlFileAlum,
            'Calificacion': 0.0,
            'Calificado': 0,
            'Comentario': comentario,
            'Comentario_Profe': '',
            'Id_Alumno': idUser,
            'Id_Grupo': idGrupo,
            'Id_Tarea': idTarea,
            'Nombre_Alumno': nombreAlumno,
            'Status': 'entregado'
          }).then((value){
            statusMessage('Se ha actualizado tu Tarea');
          });
        });
      }
    });
  }

    void openFileExplorer(_pickType) async {
    try {
      _path = await FilePicker.getFilePath(
          type: _pickType);
      nombreBoton = _path.toString().split('/').last;
      print(nombreBotonSubir);
      setState(() {
        nombreBotonSubir = _path.toString().split('/').last;
      });
    } on PlatformException catch (e) {
      print('operacion no soportada: ' + e.toString());
    }
    if (!mounted) {
      return;
    }
  }

  void uploadToFirebase() {
    fileName = _path.toString().split('/').last;
    String filePath = _path;
    upload(fileName, filePath);
  }

  /// funcion vacia que recibe el [fileName] y el [filePath] para subir el archivo al storage
  void upload(fileName, filePath) {
    _extension = fileName.split('.').last;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(idGrupo + "/" + fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
        File(filePath),
        StorageMetadata(
          contentType: '$_pickType/$_extension',
        ));
    setState(() {
      _task.add(uploadTask);
    });
  }

  void intentaConectar(){
    uploadToFirebase();
    obtenerLinkArchivo().then((value) {
      enviarTarea(idUser, idTarea, comentarioAlumno.text, idGrupo, value);
    });

  }

  Widget mostrarComentario(String texto) {
    return Text(
      '$texto',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      textAlign: TextAlign.justify,
    );
  }

   void statusMessage(String mensaje){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
                children: <Widget>[
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 5),
                  Text('Aviso'),
                ],
            ),
            content: Text(
              mensaje,
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
                //mainAxisAlignment: MainAxisAlignment.end,
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              padding: EdgeInsets.all(3.0),
              child: Container(
                decoration:BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 3, color: Colors.blue),
                    ),
                padding: EdgeInsets.all(1.0),
                child: Text('Aceptar', style: TextStyle(color: Colors.blue)),
              ),      
            )],
          );
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(Elementos.contenedor),
          title: Text('$nombreTarea'),
          centerTitle: true,
          actions: [
            IconButton(
                icon:
                    IconAppBar(), //metodo donde se crea la referencia al icono
                onPressed: null)
          ],
        ),
        drawer: MenuAppStdn(idUser),
        body: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.1765,
              height: MediaQuery.of(context).size.height / 4,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: Elementos.widthBorder,
                      color: Color(Elementos.bordes)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(Elementos.contenedor)),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.assignment, color: Colors.white),
                    title: mostrarComentario(descTarea),
                  )
                ],
              ),
            ),
            Divider(),
            //En este bloque se agrega la funcionalidad para descargar archivo profesor
                    Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Archivo de tarea',
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
                                      //downloadFile(datos['Archivo'],datos['Material_Apoyo']);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            Divider(),
            //En este bloque se agrega la funcionalidad para subir archivo alumno
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  //width: MediaQuery.of(context).size.width / 2.86,
                  //height: MediaQuery.of(context).size.height / 10,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                        side: BorderSide(
                          color: Color(Elementos.bordes),
                          width: 3,
                        )),
                    color: Color(Elementos.contenedor),
                    onPressed: () {
                      openFileExplorer(FileType.any);
                      print('boton presionado');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          nombreBotonSubir,
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.file_upload,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //TextField para insertar comentario del Alumno
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width / 1.1765,
                        height: MediaQuery.of(context).size.height / 5,
                        child: TextField(
                          autocorrect: true,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.add_comment),
                            labelText: 'Agregar Comentario',
                          ),
                          keyboardType: TextInputType.multiline,
                          controller: comentarioAlumno,
                          maxLength: 150,
                          scrollController: ScrollController(
                              initialScrollOffset: 0.0,
                              keepScrollOffset: false),
                        )),
                  ],
                ),
              ],
            ),

            //Botonoes Inferiores para envio y revison de resultados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //Boton para enviar informacion
                Container(
                  width: MediaQuery.of(context).size.width / 2.86,
                  height: MediaQuery.of(context).size.height / 14.28,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                        side: BorderSide(
                          color: Color(Elementos.bordes),
                          width: 3,
                        )),
                    color: Color(Elementos.contenedor),
                    onPressed: (){
                      intentaConectar();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Entregar',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.label_important,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                //Boton para acceder a resultados
                Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: MediaQuery.of(context).size.height / 14.28,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                        side: BorderSide(
                          color: Color(Elementos.bordes),
                          width: 3,
                        )),
                    color: Color(Elementos.contenedor),
                    onPressed: () {
                      Firestore.instance.collection('Tarea_Alumno').where('Id_Alumno', isEqualTo: idUser).where('Id_Tarea', isEqualTo: idTarea).getDocuments().then((value){
                        if(value.documents.isEmpty){
                          statusMessage('No has entregado tu tarea, Imposible mostrar resultados');
                      }
                        else{
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VistaCalificaciones(
                                  idGrupo, value.documents[0].documentID, idUser)));
                        }
                      });
                      
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Calificacion',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.check_box,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
