import 'package:flutter/material.dart';
//import 'package:puma_home/src/resources/MenuApp_tch.dart';
//import 'package:puma_home/src/resources/iconAppBar.dart';
//import 'package:puma_home/src/resources/App_Elements.dart';




  //Controladores para los campos del formulario

  TextEditingController nombreTarea = new TextEditingController();
  TextEditingController descripcionTarea = new TextEditingController();
  //TextEditingController _date = new TextEditingController();
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
