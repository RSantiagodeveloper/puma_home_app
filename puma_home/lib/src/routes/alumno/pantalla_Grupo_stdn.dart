/*
 * Pantalla de grupo del alumno
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/routes/alumno/tablon_stdn.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/alumno/material_Apoyo_stdn.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/routes/alumno/tareas_stdn.dart';
import 'package:puma_home/src/routes/servicios/contacto.dart';

//
class PantallaGrupoS extends StatelessWidget {
  final String idUser; //id del usuario actual
  final String idGroup; //id del Grupo Actual
  PantallaGrupoS(this.idUser, this.idGroup);

  final int bgColor = 0xFF040367;
  final int borderColor = 0xFFBEAF2A;
  final double widthBorder = 5.0;

  Widget createTareasButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: widthBorder, color: Color(borderColor)),
            borderRadius: BorderRadius.circular(20),
            color: Color(bgColor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Tareas'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Tareas()),
            );
          },
        ));
  }

  Widget createContactoButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: widthBorder, color: Color(borderColor)),
            borderRadius: BorderRadius.circular(20),
            color: Color(bgColor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Contacto profesor'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contacto()),
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
            border: Border.all(width: widthBorder, color: Color(borderColor)),
            borderRadius: BorderRadius.circular(20),
            color: Color(bgColor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Material de apoyo'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MaterialApoyo()),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppStdn(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Grupo'),
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
              TablonAnunciosStdn(idGroup),
              Divider(),
              createTareasButton(context),
              Divider(),
              createContactoButton(context),
              Divider(),
              createMaterialButton(context),
            ],
          )),
    );
  }
}
