import 'package:flutter/material.dart';
import 'package:puma_home/MenuApp.dart';

final _formKey = GlobalKey<FormState>(); //variable necesaria para el formulario 

class CrearTarea extends StatefulWidget {
  @override
  _CrearTareaState createState() => _CrearTareaState();
}

class _CrearTareaState extends State<CrearTarea> {

  @override
  Widget build(BuildContext context) {
    DateTime _fechaEntrega;
    return Scaffold(
      appBar: new AppBar(
        title: new Title(
          color: Colors.blue,
          child: Text("Crear una Tarea Nueva"),
        ),
      ),
      drawer: new MenuApp(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        children: <Widget>[
          _introducirTexto(context),
           ListTile(
            leading: Icon(Icons.date_range),
            title: Text("Fecha de entrega"),
            subtitle: Text(_fechaEntrega.toString()),
            onTap: (){
             showDatePicker(
               context: context, 
               initialDate: DateTime.now(), 
               firstDate: DateTime(2020), 
               lastDate: DateTime(2100)
               ).then((date){
                 setState((){
                   _fechaEntrega=date;
                 });
               })
               ;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // AQUI ENTRA LA LOGICA DE VALIDACION DE DATOS DE LOS CAMPOS
            //CUalquier consulta a Bases se coloca aqui
          }
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

Widget _introducirTexto(BuildContext context) {
  
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Nombre de la Tarea',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'campo obligatorio'; //NOTA PARA EQUIPO BACKEND: Pongan condicional evitar mandar caracteres especiales
                //  y que la base de datos no se la lleve la verga
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Descripción',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo Obligatorio';
              }
              return null;
            },
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text("Subir un Archivo"),
            subtitle: Text("No has Subido ningun archivo"),
            onTap: () {
              
            },
          ),
        ],
      ),
    ),
  );
}
