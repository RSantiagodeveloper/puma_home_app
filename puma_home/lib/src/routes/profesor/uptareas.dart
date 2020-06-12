import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart'; //import del PlatformException
import 'package:puma_home/src/resources/App_Elements.dart';


class SubirArchivo extends StatefulWidget{
    _SubirArchivoState createState() => _SubirArchivoState();
}

class _SubirArchivoState extends State< SubirArchivo>{
    TextEditingController nombreTarea = new TextEditingController();
    TextEditingController descripcionTarea = new TextEditingController();
    TextEditingController _date = new TextEditingController();
    GlobalKey<FormState> keyForm = new GlobalKey();

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
		String fileName= _path.toString().split('/').last;
		String filePath = _path;
		upload(fileName, filePath);
}

/// funcion vacia que recibe el [fileName] y el [filePath] para subir el archivo al storage
void upload(fileName, filePath){
	_extension = fileName.split('.').last;
	StorageReference storageRef =FirebaseStorage.instance.ref().child("prueba/"+fileName);
	final StorageUploadTask uploadTask =
		storageRef.putFile(File(filePath),StorageMetadata(
				contentType: '$_pickType/$_extension',
			)
		);
	setState((){
		_task.add(uploadTask);
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
            onPressed: () {uploadToFirebase();}
        ),
    );
}
/// widget que devuelve un DropdownButton para seleccionar el filtro del archivos
Widget botonTypeFile() {
    return DropdownButton(
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