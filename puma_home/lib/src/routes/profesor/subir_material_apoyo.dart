import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SubirMaterialApoyo extends StatefulWidget {
  final String idUser;
  final String idGrupo;
  SubirMaterialApoyo(this.idUser, this.idGrupo);
  @override
  _SubirMaterialApoyoState createState() =>
      _SubirMaterialApoyoState(idUser, idGrupo);
}

class _SubirMaterialApoyoState extends State<SubirMaterialApoyo> {
  final String idUserstate;
  final String idgrupoState;
  _SubirMaterialApoyoState(this.idUserstate, this.idgrupoState);

  String fileName = 'nombre de archivo esta vacio';
  String nombreBoton = 'Buscar archivo';
  String _extension;
  String _path;
  FileType _pickType;
  List<StorageUploadTask> _task = <StorageUploadTask>[];
  bool activado = false;
  bool _multiPick = false;
  bool downloading = false; //variables globales
  var progressString = "";

  @override
  void initState() {
    super.initState();
    print('recibi al usuario $idUserstate');
  }

  GlobalKey<FormState> keyForm = new GlobalKey();

  ///widget que devuelve un boton para abrir el explorador de archivos nativo
  Widget botonFind() {
    return OutlineButton(
        child: Text(nombreBoton),
        onPressed: () {
          openFileExplorer(_pickType);
        });
  }

  /// metodo para abrir el explorador de archivos y cargar un archivo
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
  void uploadToFirebase() {
    fileName = _path.toString().split('/').last;
    String filePath = _path;
    upload(fileName, filePath);
  }

  /// funcion vacia que recibe el [fileName] y el [filePath] para subir el archivo al storage
  void upload(fileName, filePath) {
    _extension = fileName.split('.').last;
    StorageReference storageRef = FirebaseStorage.instance
        .ref()
        .child(idgrupoState + "/material_de_apoyo/" + fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
        File(filePath),
        StorageMetadata(
          contentType: '$_pickType/$_extension',
        ));
    setState(() {
      _task.add(uploadTask);
    });
  }

  String dropdownValue;

  ///funcion vacia que aisgna el FileType a _pickType dependiendo el [tipo]
  void asignarValor(String tipo) {
    switch (tipo) {
      case "Audio":
        {
          _pickType = FileType.audio;
        }
        break;
      case "Video":
        {
          _pickType = FileType.video;
        }
        break;
      case "Imagen":
        {
          _pickType = FileType.image;
        }
        break;
      case "Otro":
        {
          _pickType = FileType.any;
        }
        break;
      default:
        {
          //_pickType=FileType.any;
        }
        break;
    }
  }

  ///widget que devuelve un dropdownbutton para seleccionar un tipo de archivo
  Widget seleccionarTipoArchivo() {
    return DropdownButton<String>(
      hint: Text('Selecciona'),
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          asignarValor(dropdownValue);
          print(_pickType.toString());
        });
      },
      items: <String>['Audio', 'Video', 'Imagen', 'Otro']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget botonMultiArch() {
    return SwitchListTile.adaptive(
      title: Text(
        'multiple archivos',
        textAlign: TextAlign.left,
      ),
      onChanged: (bool value) {
        setState(() {
          _multiPick = value;
        });
      },
      value: _multiPick,
    );
  }

  // widget hint
  Widget showWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile.adaptive(
            title: Text(
              'subir archivos',
              textAlign: TextAlign.left,
            ),
            onChanged: (bool value) {
              setState(() {
                activado = value;
              });
            },
            value: activado,
          ),
          activado
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 11,
                      child: botonMultiArch(),
                    ),
                  ],
                )
              : Container(),
          activado
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 11,
                      child: seleccionarTipoArchivo(),
                    ),
                  ],
                )
              : Container(),
          activado
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 11,
                      child: botonFind(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Subir Material Apoyo',
            style: TextStyle(color: Color(Elementos.bordes))),
      ),
      body: Form(
        key: keyForm,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: new ListView(
            children: <Widget>[showWidget()],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: Color(Elementos.bordes),
        child: Icon(Icons.file_upload),
      ),
    );
  }
}
