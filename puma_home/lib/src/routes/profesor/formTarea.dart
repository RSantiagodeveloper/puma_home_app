import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:puma_home/src/routes/servicios/confiReg.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/App_Elements.dart';


class CrearTarea extends StatefulWidget{
    _CrearTareaStatet createState() => _CrearTareaStatet();
}

class _CrearTareaStatet extends State< CrearTarea>{
    TextEditingController nombreTarea = new TextEditingController();
    TextEditingController descripcionTarea = new TextEditingController();
    TextEditingController _date = new TextEditingController();
    GlobalKey<FormState> keyForm = new GlobalKey();
     

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

Widget botonUp(BuildContext context) {
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
                'Subir archivo',
                style: TextStyle(color: Colors.white),
            ),
            onPressed: () {}
        ),
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
              crearBoton(context),
              Divider(),
              botonUp(context),
            ],
          ),
        ),
      ),
    );
  }


}

