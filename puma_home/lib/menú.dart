import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'MiPerfil.dart';
import 'EliminarClase.dart';
import 'VerGrupos.dart';
import 'CrearClase.dart';

class Menu extends StatelessWidget {


  Widget createCrearClaseButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Crear clase'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => CrearClase()),
          );
      },
      )
      );
  }
  
    Widget createVerGruposButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Ver mis grupos'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => VerGrupos()),
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


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MenuApp(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Administración'),
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
            createCrearClaseButton(context),
            createVerGruposButton(context),
            createEliminarClaseButton(context),
            createMiPerfilButton(context),

          ],
        )
        
      ),
    );
  }
}