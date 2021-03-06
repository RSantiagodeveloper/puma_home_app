/*
 * @author: Ricardo santiago Lopez.
 * @email: ricardosantilo96@gmail.com
 * @descripcion:
 *  En este archivo esta definida la funcionalidad del menu interactivo de la applicacion.
 * Para agregarlo a la pantalla solo hay que importar este archivo a su codigo y
 * agregar la linea
 *  drawer:MenuApp()
 * en el scaffold (Vea el ejemplo en el archivo [rutaEjemplo.dart])
 * La imagen que se muestra en el menu, ya esta determinada dentro de la ruta especificada
 * Si se desea cambiar el logo en general. solo hay que cambiar la imagen en la ruta, conservando
 * el mismo nombre.
 * Si desea cambiar la imagen para cada pantalla en particular. Hay que agregar la ruta nueva y 
 * las configuraciones.
 * 
 * 
 * @note:
 *  Para agregar el diseño de la appBar, solo hay que copiar y pegar el siguiente codigo en el Scaffold:
 * 
     appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Titulo_Pantalla'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: IconAppBar(),//metodo donde se crea la referencia al icono
            onPressed: null
          )
        ],
      ),

  * de esta manera se conserva el diseño.
  * Solo recuerde cambiar el titulo de la pantalla que esta mostrando. 
  * Si desea cambiar el icono de la appbar en general, hay que dirigirse a la ruta
  * images/iconos/ y sustituir el archivo appbarIcon.png por otro archivo con el mismo nombre.
  * Si desea cambiar el icono en una pantalla en especifico hay que cambiar la ruta especificada 
  * en el archivo [iconBarApp.dart]

  * PROCURE QUE ESTE ARCHIVO ESTE DENTRO DE LA CARPETA lib, para el buen funcionamiento
  * 
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puma_home/src/routes/profesor/menu_tch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puma_home/src/routes/servicios/loginPage.dart';

class MenuAppTch extends StatefulWidget {
  final String userID;
  MenuAppTch(this.userID);
  _MenuAppTchState createState() => _MenuAppTchState(userID);
}

class _MenuAppTchState extends State<MenuAppTch> {
  String userIDState;
  _MenuAppTchState(this.userIDState);
  final double sizeOption = 16.0;
  final double sizeTitle = 20.0;
  //metodo que contruye el Menu desplegable en pantalla
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          child: Text(
            'PUMA-HOME MENÚ\nProfesor',
            style: TextStyle(fontSize: sizeTitle, color: Colors.white),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('images/logos/menu_logo.jpeg'), //logo del menu
                  fit: BoxFit.cover)),
        ),
        //acesso a la pantalla de Administracion
        new ListTile(
          title: Text(
            'Administración',
            style: TextStyle(fontSize: sizeOption),
          ),
          leading: Icon(Icons.work),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuTch(userIDState)),
            );
          },
        ),
        //TODO: Implementar funcionalidad de Notificaciones en Versiones siguientes
        new ListTile(
          title: Text(
            'Notificaciones',
            style: TextStyle(fontSize: sizeOption),
          ),
          leading: Icon(Icons.notifications),
          onTap: () {
            _proximamente();
          },
        ),
        //Boton que despilega un Alert para mostrar informacion de la APP y El equipo
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
        //Aqui debe de ir el LogOut
        new ListTile(
          title: Text(
            'Cerrar Sesión',
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
