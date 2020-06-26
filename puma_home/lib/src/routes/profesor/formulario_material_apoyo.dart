/*
 *Pantalla de formulario para que el profesor pueda subir material de apoyo para algun grupo. 
 */
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class MaterialApoyoFormTch extends StatefulWidget {
  final String idUser;
  final String idGrupo;
  MaterialApoyoFormTch(this.idUser, this.idGrupo);
  MaterialApoyoTchFormState createState() {
    return MaterialApoyoTchFormState(idUser, idGrupo);
  }
}

class MaterialApoyoTchFormState extends State<MaterialApoyoFormTch> {
  String idUserState;
  String idGrupoState;
  String fileName = 'nombre de archivo esta vacio';
  MaterialApoyoTchFormState(this.idUserState, this.idGrupoState);
  TextEditingController descripcionArchivo = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();
  bool activado = false;
  //bool _multiPick = false;
  bool downloading = false; //variables globales
  var progressString = "";
  String _extension;
  FileType _pickType;
  String _path;
  String nombreBoton = 'Buscar archivo';
  List<StorageUploadTask> _task = <StorageUploadTask>[];

  @override
  void initState() {
    super.initState();
    print('recibi al usuario $idUserState, $idGrupoState');
  }
//Funcion asincrona para abrir el explorador de archivos.
  void openFileExplorer(_pickType) async {
    try {
      _path = await FilePicker.getFilePath(
          type: _pickType /*, allowedFileExtension: _extension*/);
      nombreBoton = _path.toString().split('/').last;
      print(nombreBoton);
      setState(() {
        nombreBoton = _path.toString().split('/').last;
      });
    } on PlatformException catch (e) {
      print('operacion no soportada: ' + e.toString());
    }
    if (!mounted) {
      return;
    }
  }

  ///funciona que sube el archivo seleccionado al storage
  String uploadToFirebase() {
    String link;
    fileName = _path.toString().split('/').last;
    String filePath = _path;
    upload(fileName, filePath);
    StorageReference ref =
        FirebaseStorage.instance.ref().child(idGrupoState + "/" + fileName);
    ref.getDownloadURL().then((value) {
      link = value.toString();
      print("La variable link contine: " + link);
    });
    return link;
  }

  /// funcion vacia que recibe el [fileName] y el [filePath] para subir el archivo al storage
  void upload(fileName, filePath) {
    _extension = fileName.split('.').last;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(idGrupoState + "/" + fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
        File(filePath),
        StorageMetadata(
          contentType: '$_pickType/$_extension',
        ));
    uploadTask.events.listen((event) {
      print(event.type.index);
      if (event.type == StorageTaskEventType.progress) {
        print('En progreso');
      } else if (event.type == StorageTaskEventType.success) {
        print('Proceso Finalizado');
        StorageReference ref =
            FirebaseStorage.instance.ref().child(idGrupoState + "/" + fileName);
        ref.getDownloadURL().then((value) {
          baseForm(fileName, value.toString());
        });
      }
    });
  }

  void baseForm(fileName,link) {
      Firestore.instance.collection('Material_Apoyo').add({
        'Descripcion': descripcionArchivo.text,
        'Id_profesor': idUserState,
        'Id_Grupo': idGrupoState,
        'Archivo': link,
        'Nombre_Archivo': fileName,
      }).then((_) {
        Navigator.pop(context);
      });
  }

  void intentarConectar() async {
    fileName = _path.toString().split('/').last;
    String filePath = _path;
    upload(fileName, filePath);
  }

  Widget nombreDescripcionField() {
    //campo para almacenar la descripción de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: descripcionArchivo,
        decoration: InputDecoration(
          labelText: 'Descripcion del Archivo:',
        ),
      ),
    );
  }

  Widget subirMaterial(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 6.67,
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FlatButton(
          child: Text(
            'Subir archivo',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            intentarConectar();
          }),
    );
  }

  Widget exploradorArchivo() {
    return Expanded(
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
              nombreBoton,
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.file_upload,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

//Widget que manda a llamar las funciones anteriores
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Sube Archivo',
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
      ),
      body: Form(
        key: keyForm,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: new ListView(
            children: <Widget>[
              Divider(),
              nombreDescripcionField(),
              Divider(),
              exploradorArchivo(),
              Divider(),
              subirMaterial(context),
            ],
          ),
        ),
      ),
    );
  }
}
