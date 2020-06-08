/*
 * Pantalla de grupo del profesor
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/profesor/formTarea.dart';
import 'package:puma_home/src/routes/profesor/material_Apoyo_tch.dart';
import 'package:puma_home/src/routes/profesor/tablon_tch.dart';
//import 'package:puma_home/src/routes/profesor/tareas_tch.dart';
//import 'package:puma_home/src/routes/profesor/tareas_tch.dart';
//import 'package:puma_home/src/routes/profesor/tareas_tch.dart';
//import 'package:puma_home/src/routes/profesor/tareas_tch.dart';
//import 'package:puma_home/src/routes/profesor/tareas_tch.dart';
//import 'package:puma_home/src/routes/profesor/tareas_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
//
class PantallaGrupoTch extends StatelessWidget {
  final String idUser; //id del usuario actual
  final String idGroup; //id del Grupo Actual
  PantallaGrupoTch(this.idUser, this.idGroup);



  Widget createTareasButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Tareas'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CrearTarea()),
            );
          },
        ));
  }

  Widget createMaterialButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Material de apoyo'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MaterialApoyoTch(idUser)),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(idUser),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Pantalla Grupo', 
        style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),

      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              Text('Trabajo con el Usuario $idUser y con el Grupo $idGroup'),
              TablonAnunciosTch(idGroup),
              Divider(),
              createTareasButton(context),
              Divider(),
              createMaterialButton(context),
            ],
          )),
    );
  }
}
