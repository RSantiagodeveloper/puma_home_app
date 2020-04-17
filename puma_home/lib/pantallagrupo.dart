import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'tareas.dart';
import 'contacto.dart';
import 'materialdeapoyo.dart';
import 'tablon.dart';
//
class PantallaGrupo extends StatelessWidget {

 
    Widget createTareasButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Tareas'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Tareas()),
          );
      },
      )
      );
  }

    Widget createContactoButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Contacto profesor'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Contacto()),
          );
      },
      )
      );
  }
    Widget createMaterialButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Material de apoyo'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => MaterialApoyo()),
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
        title: Text('Grupo'),
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
            TablonAnuncios(),
            createTareasButton(context),
            createContactoButton(context),
            createMaterialButton(context),

          ],
        )
        
      ),
    );
  }
}