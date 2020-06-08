import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';




  //Controladores para los campos del formulario

  TextEditingController Nombre_tarea = new TextEditingController();
  TextEditingController Descripcion_tarea = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  GlobalKey<FormState> keyForm = new GlobalKey();

//EDITAR PARA QUE TENGA UNA VISTA MÁS BONITA :3
Widget Nombre_tareaField() {
    //campo para almacenar el nombre de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: Nombre_tarea,
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
Widget Nombre_descripcionField() {
    //campo para almacenar la descripción de la tarea
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: Descripcion_tarea,
        decoration: InputDecoration(
          labelText: 'Descripcion de la tarea de la Tarea:',
        ),
      ),
    );
  }
