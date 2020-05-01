import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'menú.dart';
import 'menualumno.dart';
import 'pantallagrupo.dart';
//
class MiniMenu extends StatelessWidget {
  final int bgColor = 0xFF040367;
  final int borderColor = 0xFFBEAF2A;
  final double widthBorder = 5.0;

 
    Widget createMenuAlumnoButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width/1.2,
        height: MediaQuery.of(context).size.height/6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
                  border: Border.all(width: widthBorder, color: Color(borderColor)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(bgColor)),
      child: FlatButton(
        textColor: Colors.white,
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
        width: MediaQuery.of(context).size.width/1.2,
        height: MediaQuery.of(context).size.height/6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
                  border: Border.all(width: widthBorder, color: Color(borderColor)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(bgColor)),
      child: FlatButton(
        textColor: Colors.white,
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
        width: MediaQuery.of(context).size.width/1.2,
        height: MediaQuery.of(context).size.height/6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
                  border: Border.all(width: widthBorder, color: Color(borderColor)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(bgColor)),
      child: FlatButton(
        textColor: Colors.white,
        child: Text('Pantalla de Grupo'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => PantallaGrupo('userX','grpY')),
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
            Divider(),
            createMenuAlumnoButton(context),
            Divider(),
            createMenuProfesorButton(context),
            Divider(),
            createPantallaGrupoButton(context),

          ],
        )
        
      ),
    );
  }
}