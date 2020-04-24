/**
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
import 'package:puma_home/men%C3%BA.dart';

class MenuApp extends StatefulWidget{
  _MenuAppState createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp>{
  final double sizeOption = 16.0;
  final double sizeTitle = 20.0;
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'PUMA-HOME MENÚ',
              style: TextStyle(
                fontSize: sizeTitle,
                color: Colors.white
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logos/menu_logo.jpeg'),//logo del menu
                fit: BoxFit.cover
              )
            ),
          ),

          new ListTile(
            title: Text(
              'Administración',
              style: TextStyle(
                fontSize: sizeOption
              ),
            ),
            leading: Icon(Icons.work),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Menu()),
              );
            },
          ),
          new ListTile(
            title: Text(
              'Notificaciones',
              style: TextStyle(
                fontSize: sizeOption
              ),
            ),
            leading: Icon(Icons.notifications),
            onTap: (){
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
              style: TextStyle(
                fontSize: sizeOption
              ),
            ),
            leading: Icon(Icons.help),
            onTap: (){
              _showInfo();
            },
          ),
          new ListTile(
            title: Text(
              'salir',
              style: TextStyle(
                fontSize: sizeOption
              ),
            ),
            leading: Icon(Icons.exit_to_app),
            onTap: (){
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ruta),
              );*/
            },
          ),
        ]
      ),
    );
  }
  _showInfo(){
    showDialog(
      context: context,
      builder: (buildcontext){
        return AlertDialog(
          title: Text('Puma Home App'),
          content: Text(
            'App de clases en linea pensada para la comunidad Univiersitaria\n Desarrollada por el Laboratorio de innovación UNAM Mobile (c)2020',
            style: TextStyle(
              fontSize: 14
            ),
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.check, color: Colors.white,),
              onPressed: (){Navigator.of(context).pop();},
            )
          ],
        );
      }
    );
  }
}