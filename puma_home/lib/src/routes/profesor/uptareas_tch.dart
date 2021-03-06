/*
* Archivo que permite que el profesor suba una tarea.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart'; //import del PlatformException
import 'package:puma_home/src/resources/App_Elements.dart';

class SubirArchivo extends StatefulWidget {
  final String idUser;
  final String idGrupo;
  SubirArchivo(this.idUser, this.idGrupo);

  _SubirArchivoState createState() => _SubirArchivoState(idUser, idGrupo);
}

class _SubirArchivoState extends State<SubirArchivo> {
  final String idUserstate;
  final String idgrupoState;
  _SubirArchivoState(this.idUserstate, this.idgrupoState);
  TextEditingController nombreTarea = new TextEditingController();
  TextEditingController descripcionTarea = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  GlobalKey<FormState> keyForm = new GlobalKey();
  final fireReference = Firestore.instance;
  String fileName = 'nombre de archivo esta vacio';
  String nombreBoton = 'Buscar archivo';
  bool stateProccess = false;

  bool activado = false;
  bool _multiPick = false;

  //bool _multiPick = false;
  //Map<String, String> _paths;
  String _extension;
  FileType _pickType;
  String _path;
  //List<StorageUploadTask> _task = <StorageUploadTask>[];

/*     hace falta modificarlo para subir varios archivos a la vez
void openFileExplorer() async {
	
			
    _path = await FilePicker.getFilePath(type: _pickType);
		uploadToFirebase();  
 fileExtension: _ fileExtension: _ fileExtension: _ fileExtension: _ fileExtension:  fileExtension:  fileExtension fileExtension fileExtension fileExtensio,	} on PlatformException catch (e){
		print('operacion no soportada'+e.toString());
	}
	if(!mounted){
		return;
	}
}
*/


  void intentarConectar() async {
    fileName = _path.toString().split('/').last;
    String filePath = _path;
    upload(fileName, filePath);
    //var enlace =  await uploadToFirebase(); //este sube al storage
    //print("El valor que devuelve uploadToFirebase es: "+enlace.toString());
    //baseForm(fileName, enlace); //este sube a la firestore
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
  Future<dynamic> uploadToFirebase() async {
    fileName = _path.toString().split('/').last;
    String filePath = _path;
    upload(fileName, filePath);
    StorageReference ref =
        FirebaseStorage.instance.ref().child(idgrupoState + "/" + fileName);
    return await ref.getDownloadURL();
  }

  /// funcion vacia que recibe el [fileName] y el [filePath] para subir el archivo al storage
  void upload(fileName, filePath) {
    _extension = fileName.split('.').last;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(idgrupoState + "/" + fileName);
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
            FirebaseStorage.instance.ref().child(idgrupoState + "/" + fileName);
        ref.getDownloadURL().then((value) {
          baseForm(fileName, value.toString());
        });
      }
    });
  }

  ///funcion vacia que manda los datos de la tarea a la base de datos
  void baseForm(fileName, link) {
    Firestore.instance.collection('Tareas').add({
      'Nombre': nombreTarea.text,
      'Descripcion': descripcionTarea.text,
      'FechaEntrega': _date.text,
      'Id_profesor': idUserstate,
      'Id_Grupo': idgrupoState,
      'Archivo': link,
      'Nombre_Archivo': fileName,
    }).then((_) {
      Navigator.pop(context);
    });
  }

  ///widget switch que al estar activado permite subir multiples archivos
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

// widget contenedor con un switch que permite activar o desactivar los widgets para subir archivos
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

//EDITAR PARA QUE TENGA UNA VISTA M??S BONITA :3
  Widget nombreTareaField() {
    //campo para almacenar el nombre de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: nombreTarea,
        decoration: InputDecoration(
          labelText: 'Nombre de la Tarea:',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Rellenar campo obligatorio';
          }
          return null;
        },
      ),
    );
  }

//EDITAR PARA QUE TENGA UNA VISTA M??S BONITA :3
  Widget nombreDescripcionField() {
    //campo para almacenar la descripci??n de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: descripcionTarea,
        decoration: InputDecoration(
          labelText: 'Descripci??n de la tarea:',
        ),
      ),
    );
  }

  ///widget para introducir la fecha
  //TODO: cambiarlo a un datePicker
  Widget dateField() {
    //campo para almacenar la descripci??n de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _date,
        decoration: InputDecoration(
          labelText: 'Fecha Entrega (dd/mm/aaaa):',
        ),
        maxLength: 10,
      ),
    );
  }

  ///widget que devuelve un container con un flatbutton para
  Widget crearBoton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.85,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FlatButton(
          child: Text(
            'Publicar tarea',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState((){
              stateProccess = true;
            });
            intentarConectar();
          }),
    );
  }

  /// widget que devuelve un DropdownButton para seleccionar el filtro del archivos
  Widget botonTypeFile() {
    return DropdownButton(
      hint: Text('selecciona'),
      items: <DropdownMenuItem>[
        DropdownMenuItem(
          child: Text('Audio'),
          value: FileType.audio,
        ),
        DropdownMenuItem(
          child: Text('Imagen'),
          value: FileType.image,
        ),
        DropdownMenuItem(
          child: Text('Video'),
          value: FileType.video,
        ),
        DropdownMenuItem(
          child: Text('Otro'),
          value: FileType.any,
        ),
      ],
      onChanged: (value) {
        setState(() {
          _pickType = value; //le asigna el valor seleccionado al _pickType
        });
      },
    );
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

  ///widget que devuelve un boton para abrir el explorador de archivos nativo
  Widget botonFind() {
    return OutlineButton(
        child: Text(nombreBoton),
        onPressed: () {
          openFileExplorer(FileType.any);
        });
  }

  Widget barraStatus(){
    return Container(
      child: (stateProccess == false)? Text('Esperando publicar tarea', style: TextStyle(color: Colors.red),): Text('La tarea se est?? publicando, espera ...', style: TextStyle(color: Color(Elementos.contenedor))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('A??adir nueva tarea',
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
      ),
      body: Form(
        key: keyForm,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: new ListView(
            children: <Widget>[
              nombreTareaField(),
              Divider(),
              nombreDescripcionField(),
              Divider(),
              dateField(),
              Divider(),
              //showWidget(),
              botonFind(),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  barraStatus(),
              ]),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  crearBoton(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
