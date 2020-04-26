import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'menú.dart';
import 'menualumno.dart';
import 'pantallagrupo.dart';
//
class MiniMenu extends StatelessWidget {

 
    Widget createMenuAlumnoButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Menú de Alumno'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => MenuAlumno()),
          );
      },
      )
      );
  }

    Widget createMenuProfesorButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Menú de Profesor'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Menu()),
          );
      },
      )
      );
  }

    Widget createPantallaGrupoButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Pantalla de Grupo'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => PantallaGrupo()),
          );
      },
      )
      );
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MenuApp(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Mini Menú'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: IconAppBar(),//metodo donde se crea la referencia al icono
            onPressed: null
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: ListView(
          children: [
            createMenuAlumnoButton(context),
            createMenuProfesorButton(context),
            createPantallaGrupoButton(context),

          ],
        )
        
      ),
    );
  }
}