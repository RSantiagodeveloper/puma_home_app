/**
 * Pantalla de grupo del profesor
 */
import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'tareas.dart';
import 'contacto.dart';
import 'materialdeapoyo.dart';
import 'tablon.dart';

//
class PantallaGrupo extends StatelessWidget {
  final String idUser; //id del usuario actual
  final String idGroup; //id del Grupo Actual
  PantallaGrupo(this.idUser, this.idGroup);

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
      drawer: MenuApp(),
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
              Text('Trabajo con el Usuario $idUser y con el Grupo $idGroup'),
              TablonAnuncios(idGroup),
              Divider(),
              createTareasButton(context),
              Divider(),
              createMaterialButton(context),
            ],
          )),
    );
  }
}
