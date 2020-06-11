import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:puma_home/src/resources/App_Elements.dart';


class CrearTarea extends StatefulWidget{
    _CrearTareaStatet createState() => _CrearTareaStatet();
}

class _CrearTareaStatet extends State< CrearTarea>{
    TextEditingController nombreTarea = new TextEditingController();
    TextEditingController descripcionTarea = new TextEditingController();
    TextEditingController _date = new TextEditingController();
    GlobalKey<FormState> keyForm = new GlobalKey();

    String _path;
    Map<String, String> _paths;
    String _extension;
    FileType _pickType;
    bool _multiPick = false;
    GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey();
    List<StorageUploadTask> _task = <StorageUploadTask>[];

     
void openFileExplorer() async {
	try{
		_path = null;
		if(_multiPick){
			_path = await FilePicker.getMultiFile(
				type:_pickType,
				fileExtension:_extension
			);
		}
		else{
			_path = await FilePicker.getFilePath(
				type:_pickType,
				fileExtension:_extension
			);
		}
		uploadToFirebase();  
	} on PlatformException catch (e){
		print('operacion no soportada'+e.toString());
	}
	if(!mounted){
		return;
	}
}

void uploadToFirebase(){
	if(_multiPick){
		_paths.forEach((fileName, filePath)=>{
			upload(fileName,filePath)
		});
	}
	else{
		String fileName= _path.split('.').last;
		String filePath = _path;
		upload(fileName, filePath);
	}
}

void upload(fileName, filePath){
	_extension = fileName.toString().split('.').last;
	StorageReference storageRef =FirebaseStorage.instance.ref().child(fileName);
	final StorageUploadTask uploadTask =
		storageRef.putFile(File(filePath).StorageMetadata(
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
          labelText: 'Descripcion de la tarea de la Tarea:',
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
            onPressed: () {}
        ),
    );
}

Widget botonTypeFile() {
    return DropdownButton(
    	hint:Text('selecciona'),
    	items: <DropdownMenuItem>[
    		DropdownMenuItem(
    			child:Text('Audio');
    			value:FileType.AUDIO,
    		),
    		DropdownMenuItem(
    			child:Text('Imagen');
    			value:FileType.IMAGE,
    		),
    		DropdownMenuItem(
    			child:Text('Video');
    			value:FileType.VIDEO,
    		),
    		DropdownMenuItem(
    			child:Text('Otro');
    			value:FileType.ANY,
    		),

    	],
    	onChanged:(value){
    		setState(
    			(){
    				_pickType=value;
    			}
    		);
    	},
    );
}

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
              SwitchListTile.adaptive(
              	title:Text('multiple archivos',
              		textAlign:TextAlign.left,
              	),
              	onChanged:(bool value){
              		setState((){
              			_multiPick=value;
              		});
              	},
              	value:_multiPick,
              ),
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

