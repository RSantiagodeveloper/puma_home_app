import 'package:flutter/material.dart';
import 'package:puma_home/MenuApp.dart';
import 'package:puma_home/addgrupo.dart';
import 'package:puma_home/creargrupo.dart';
import 'misgrupos.dart';
import 'signin.dart';

class Caratula extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Puma_Home',
      home: Scaffold(
        drawer: MenuApp(),
        backgroundColor: Colors.lightBlueAccent[100], //color de fondo para esta pantalla
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Center(
                child: Text(
                  'Puma_Home',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                child: RaisedButton(
                  child: Text('registrarse(alumno)'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                    );
                  },                  
                ),
              ),
              Center(
                child: RaisedButton(
                  child: Text('Mis grupos (alumno)'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MisGrupos()),
                    );
                  },                  
                ),
              ),
               Center(
                child: RaisedButton(
                  child: Text('Añadir grupo  (alumno)'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Addgrupo()),
                    );
                  },                  
                ),
              ),
              Center(
                child: RaisedButton(
                  child: Text('Crear Grupo (Profesor)'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>CrearGrupo()),
                    );
                  },                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
