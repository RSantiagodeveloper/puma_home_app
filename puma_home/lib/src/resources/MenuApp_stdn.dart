/*
 * @author: Ricardo Santiago López
 * @descipcion: Este widget solo se manda a llmar en el Drawer para desplegar el menu lateral
 * en la app en algunas pantallas:
 * Es importante que este widget reciba tambien el Id_Usuario para no perder referencia del
 * Usuario con el que estamos logeados en la app
*/
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puma_home/src/routes/alumno/menu_stdn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puma_home/src/routes/servicios/loginPage.dart';

class MenuAppStdn extends StatefulWidget {
  final String userID;
  MenuAppStdn(this.userID);
  _MenuAppStdnState createState() => _MenuAppStdnState(userID);
}

class _MenuAppStdnState extends State<MenuAppStdn> {
  final String userIDstate;
  _MenuAppStdnState(this.userIDstate);
  final double sizeOption = 16.0;
  final double sizeTitle = 20.0;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          child: Text(
            'PUMA-HOME MENÚ \nAlumno',
            style: TextStyle(fontSize: sizeTitle, color: Colors.white),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('images/logos/menu_logo.jpeg'), //logo del menu
                  fit: BoxFit.cover)),
        ),
        //redireccionamiento a la pantalla de administracion
        new ListTile(
          title: Text(
            'Administración',
            style: TextStyle(fontSize: sizeOption)
          ),
          leading: Icon(Icons.work),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuAlumno(userIDstate)),
            );
          },
        ),
        Divider(),
        //TODO: Implemntar la funcionalidad de notificaciones aqui en una version futura
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
              _proximamente();
          },
        ),
        Divider(),
        //Despliega un Alert con informacion de la app y del equipo
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
        Divider(),
        //implementar aqui la funcionalidad del LogOut <- si es aqui, En el evento onpressd
        new ListTile(
          title: Text(
            'Salir',
            style: TextStyle(fontSize: sizeOption),
          ),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
              FirebaseAuth.instance.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginPage()
                ));
              });
          },
        ),
      ]),
    );
  }
  //Alert dedicado a mostrar la informacion de la App y del equipo Desarrolador
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

    _proximamente() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text('Proximamente...'),
            content: Text(
              'Pagina en desarollo',
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
