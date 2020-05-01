import 'package:flutter/material.dart';
import 'package:puma_home/mi_perfil_s.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'EliminarClase.dart';
import 'misgrupos.dart';
import 'alta.dart';
//
class MenuAlumno extends StatelessWidget {
  final int bgColor = 0xFF040367;
  final int borderColor = 0xFFBEAF2A;
  final double widthBorder = 5.0;

 
    Widget createVerGruposButton(BuildContext context) {
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
        child: Text('Ver mis grupos'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => MisGrupos()),
          );
      },
      )
      );
  }

    Widget createEliminarClaseButton(BuildContext context) {
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
        child: Text('Eliminar clase'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => EliminarClase()),
          );
      },
      )
      );
  }

    Widget createMiPerfilButton(BuildContext context) {
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
        child: Text('Mi perfil'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => MiPerfilS('userX')),
          );

      },
      )
      );
  }
     Widget createAltaButton(BuildContext context) {
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
        child: Text('Alta de clases'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => AltaClase()),
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
        title: Text('Administración (Alumno)'),
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
            createVerGruposButton(context),
            Divider(),
            createEliminarClaseButton(context),
            Divider(),
            createMiPerfilButton(context),
            Divider(),
            createAltaButton(context),

          ],
        )
        
      ),
    );
  }
}