import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart'; //import del PlatformException
import 'package:puma_home/src/resources/App_Elements.dart';


class SubirArchivo extends StatefulWidget{
    final String idUser;
    final String idGrupo;
    SubirArchivo(this.idUser, this.idGrupo);

    _SubirArchivoState createState() => _SubirArchivoState(idUser,idGrupo);
}

class _SubirArchivoState extends State< SubirArchivo>{
    final String idUserstate;
    final String idgrupoState;
    _SubirArchivoState(this.idUserstate, this.idgrupoState);
    TextEditingController nombreTarea = new TextEditingController();
    TextEditingController descripcionTarea = new TextEditingController();
    TextEditingController _date = new TextEditingController();
    GlobalKey<FormState> keyForm = new GlobalKey();
    final fireReference = Firestore.instance;
    String fileName;

    /*List<FileType> _tipoDeArchivo=<FileType>[
      FileType.audio

    ];*/
    

    String _path;
    //Map<String, String> _paths;
    String _extension;
    FileType _pickType;
    //bool _multiPick = false;
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
void intentarConectar(){
  uploadToFirebase(); //este sube al storage
  baseForm(fileName); //este sube a la firestore
}
/// metodo para abrir el explorador de archivos y cargar un archivo
void openFileExplorer() async {
  try{
    _path = await FilePicker.getFilePath(type: _pickType/*, allowedFileExtension: _extension*/);   
 }
  on PlatformException catch (e){
    print('operacion no soportada: '+e.toString());
  } 
  if(!mounted){
    return;
  }
}
///funciona que sube el archivo seleccionado al storage
void uploadToFirebase(){
		fileName= _path.toString().split('/').last;
		String filePath = _path;
		upload(fileName, filePath);
} 

/// funcion vacia que recibe el [fileName] y el [filePath] para subir el archivo al storage
void upload(fileName, filePath){
	_extension = fileName.split('.').last;
	StorageReference storageRef =FirebaseStorage.instance.ref().child(idgrupoState+"/"+fileName);
	final StorageUploadTask uploadTask =
		storageRef.putFile(File(filePath),StorageMetadata(
				contentType: '$_pickType/$_extension',
			)
		);
	setState((){
		_task.add(uploadTask);
	});
}
///funcion vacia que manda los datos de la tarea a la base de datos
void baseForm(fileName) async {
	StorageReference ref =FirebaseStorage.instance.ref().child(idgrupoState+"/"+fileName);
	final String url = await ref.getDownloadURL();
	//fireReference.collection('Tareas').document().setData({ 
  Firestore.instance.collection('Tareas').add({
        'Nombre': nombreTarea.text,
        'Descripcion': descripcionTarea.text,
        'FechaEntrega': _date.text,
        'Ids_alumnos':"",
        'Id_profesor':idUserstate,
        'Status':"NoEntregado",
        'Id_Grupo':idgrupoState,
        'Comentario_Alumno':"",
        'Comentario':"",
        'calificacion':"",
        'Archivo':url,
        'Archivos_Alumnos':"",
        
    });
    
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

Widget dateField() {
    //campo para almacenar la descripción de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _date,
        decoration: InputDecoration(
          labelText: 'Fecha Entrega (dd/mm/aaaa):',
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
            border: Border.all(width: 5, color: Color(Elementos.bordes))
        ),
        child: FlatButton(
            child: Text(
                'Subir tarea',
                style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              //uploadToFirebase(); //manda los archivos al storage
              //baseForm(fileName);
              intentarConectar();
            }
        ),
    );
}
/// widget que devuelve un DropdownButton para seleccionar el filtro del archivos
//TODO: Mejorar vista
Widget botonTypeFile() {
    return DropdownButton(
      //value: _pickType.toString(), //el valor del dropdownbutton se vuelve el del picktype?
    	hint:Text('selecciona'),
    	items: <DropdownMenuItem>[
    		DropdownMenuItem(
    			child:Text('Audio'),
    			value:FileType.audio,
    		),
    		DropdownMenuItem(
    			child:Text('Imagen'),
    			value:FileType.image,
    		),
    		DropdownMenuItem(
    			child:Text('Video'),
    			value:FileType.video,
    		),
    		DropdownMenuItem(
    			child:Text('Otro'),
    			value:FileType.any,
    		),

    	],
    	onChanged:(value){
    		setState(
    			(){
            //que seleccione el nombre del tipo y lo delvuelva al DropdownButton
            //aqui hacemos el case
    				_pickType=value; //le asigna el valor seleccionado al _pickType
    			}
    		);
    	},
    );
}
///widget que devuelve un boton para abrir el explorador de archivos nativo
Widget botonFind(){
	return OutlineButton(
		child:Text('Buscar Archivo'),
		onPressed:(){
			openFileExplorer();
		}
	);
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        	backgroundColor: Color(Elementos.contenedor),
        	title: Text('Registro', style: TextStyle(color: Color(Elementos.bordes))),
      	),
      body: Form(
        key: keyForm,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: new ListView(
            children: <Widget>[
             nombreTareaField(),
              nombreDescripcionField(),
              dateField(),
              Divider(),
              botonTypeFile(),
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
              Divider(),
              botonFind(),
              Divider(),
              crearBoton(context),
            ],
          ),
        ),
      ),
    );
  }
}