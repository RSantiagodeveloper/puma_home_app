import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart'; //import del PlatformException
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:puma_home/src/routes/alumno/vistaTareaAlumno.dart';

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
  GlobalKey<FormState> keyForm = new GlobalKey();
  VistaTareaAlumno subirFormularioTarea = new VistaTareaAlumno("","","","","","");
  final fireReference = Firestore.instance;
  String fileName = 'nombre de archivo esta vacio';
  String nombreBoton = 'Buscar archivo';
  String dropdownValue;
  bool activado = false;
  bool _multiPick = false;
  String _extension;
  FileType _pickType;
  String _path;
  List<StorageUploadTask> _task = <StorageUploadTask>[];

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

  void intentarConectar() {
    if (activado = true) {
      uploadToFirebase(); //este sube al storage
      baseForm(fileName); //este sube a la e
    } else {
      baseForm(fileName);
    }
  }

  /// metodo para abrir el explorador de archivos y cargar un archivo
  void openFileExplorer(_pickType) async {
    try {
      _path = await FilePicker.getFilePath(
          type: _pickType);
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
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(idgrupoState + "/" + fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
        File(filePath),
        StorageMetadata(
          contentType: '$_pickType/$_extension',
        ));
    setState(() {
      _task.add(uploadTask);
    });
  }
  
  ///funcion vacia que manda los datos de la tarea a la base de datos
  void baseForm(fileName) async {
    StorageReference ref =FirebaseStorage.instance.ref().child(idgrupoState + "/" + fileName);
    var url = await ref.getDownloadURL();
    String link = url.toString();
    Firestore.instance.collection('Tarea_Alumno').add({
      'Nombre': nombreTarea.text,
      'Descripcion': descripcionTarea.text,
      'Ids_alumnos': "",
      'Id_profesor': idUserstate,
      'Status': "NoEntregado",
      'Id_Grupo': idgrupoState,
      'Comentario_Alumno': "",
      'Comentario': "",
      'calificacion': "",
      'Archivo': link,
      'Archivos_Alumnos': "",
      'Nombre_Archivo':fileName,
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

//EDITAR PARA QUE TENGA UNA VISTA MÁS BONITA :3
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

//EDITAR PARA QUE TENGA UNA VISTA MÁS BONITA :3
  Widget nombreDescripcionField() {
    //campo para almacenar la descripción de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: descripcionTarea,
        decoration: InputDecoration(
          labelText: 'Descripcion de la tarea:',
        ),
      ),
    );
  }

  ///widget que devuelve un container con un flatbutton para 
  Widget crearBoton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 6.67,
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FlatButton(
          child: Text(
            'Subir tarea',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            //uploadToFirebase(); //manda los archivos al storage
            //baseForm(fileName);
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
          _pickType = value; 
        });
      },
    );
  }

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
          print("No se ha seleccionado ningun tipo de archivo");
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
          openFileExplorer(_pickType);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title:
            Text('Registro', style: TextStyle(color: Color(Elementos.bordes))),
      ),
      body: Form(
        key: keyForm,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: new ListView(
            children: <Widget>[
              nombreTareaField(),
              nombreDescripcionField(),
              Divider(),
              //botonTypeFile(),

              /*SwitchListTile.adaptive(
              	title:Text('multiple archivos',
              		textAlign:TextAlign.left,
              	),
              	onChanged:(bool value){
              		setState((){
              			_multiPick=value;
              		});
              	},
              	value:_multiPick,
              ),*/
              showWidget(),
              Divider(),
              crearBoton(context),
            ],
          ),
        ),
      ),
    );
  }
}
