/*
 * @author: Ricardo Santiago López
 * @descipcion: 
*/
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puma_home/src/routes/alumno/menu_stdn.dart';

class MenuAppStdn extends StatefulWidget {
  _MenuAppStdnState createState() => _MenuAppStdnState();
}

class _MenuAppStdnState extends State<MenuAppStdn> {
  final double sizeOption = 16.0;
  final double sizeTitle = 20.0;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          child: Text(
            'PUMA-HOME MENÚ',
            style: TextStyle(fontSize: sizeTitle, color: Colors.white),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('images/logos/menu_logo.jpeg'), //logo del menu
                  fit: BoxFit.cover)),
        ),
        new ListTile(
          title: Text(
            'Administración',
            style: TextStyle(fontSize: sizeOption),
          ),
          leading: Icon(Icons.work),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuAlumno('')),
            );
          },
        ),
        new ListTile(
          title: Text(
            'Notificaciones',
            style: TextStyle(fontSize: sizeOption),
          ),
          leading: Icon(Icons.notifications),
          onTap: () {
            /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ruta),
              );*/
          },
        ),
        new ListTile(
          title: Text(
            'Acerca de',
            style: TextStyle(fontSize: sizeOption),
          ),
          leading: Icon(Icons.help),
          onTap: () {
            _showInfo();
          },
        ),
        new ListTile(
          title: Text(
            'salir',
            style: TextStyle(fontSize: sizeOption),
          ),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ruta),
              );*/
          },
        ),
      ]),
    );
  }

  _showInfo() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text('Puma Home App'),
            content: Text(
              'App de clases en linea pensada para la comunidad Univiersitaria\n Desarrollada por el Laboratorio de innovación UNAM Mobile (c)2020',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              FloatingActionButton(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
