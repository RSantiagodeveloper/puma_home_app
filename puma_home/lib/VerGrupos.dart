import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';
import 'menú.dart';


class VerGrupos extends StatelessWidget {


    Widget createMenuButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Administración'),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Menu())
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
        title: Text('Ver grupos'),
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