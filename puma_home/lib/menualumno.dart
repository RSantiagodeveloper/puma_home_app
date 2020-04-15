import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'mi_perfil.dart';
import 'EliminarClase.dart';
import 'misgrupos.dart';
import 'alta.dart';
//
class MenuAlumno extends StatelessWidget {

 
    Widget createVerGruposButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
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
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
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
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Mi perfil'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => MiPerfil()),
          );

      },
      )
      );
  }
     Widget createAltaButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
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
            createVerGruposButton(context),
            createEliminarClaseButton(context),
            createMiPerfilButton(context),
            createAltaButton(context),

          ],
        )
        
      ),
    );
  }
}