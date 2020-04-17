import 'package:flutter/material.dart';
import 'package:puma_home/pantallagrupo.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'pantallagrupo.dart';


class Contacto extends StatelessWidget {


    Widget createMenuButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Pantalla Grupo'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => PantallaGrupo())
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
        title: Text('Contacto'),
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

            createMenuButton(context),

          ],
        )
        
      ),
    );
  }
}