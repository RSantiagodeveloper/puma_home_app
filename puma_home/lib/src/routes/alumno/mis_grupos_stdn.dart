/*
 * En este archivo se define la pantalla correspondiente a los grupos en los que un alumno está incrito.
 * 
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'alta_Grupo.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

class MisGrupos extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
}

///este widget devuelve la tarjeta individual para cada grupo
///se le tiene que pasar un string nombre para que la pueda mostrar

Widget _grupo(String nombre, String tipoClase) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Color(Elementos.contenedor),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.class_),
            title: Text(nombre),
            subtitle: Text(tipoClase),
          )
        ],
      ));
}

///funcion que obtiene los datos de firebase para los grupos
generarGrupo() {
//obtenerDatosBase();
//contarDatosBase();
//crearArregloTarjetas();
//return arregloTarjetas ;
}

///clase que devuelve un scaffold donde se encuentra la lista de los grupos a los que el alumno está inscrito
class _MisGruposState extends State<MisGrupos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Color(Elementos.contenedor),
          child: Text('Mis Grupos'),
        ),
      ),
      drawer: MenuAppStdn(),
      body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: [
            generarGrupo(),
            _grupo("Historia", "clase virtual"),
            _grupo("Matematicas", "clase prensencial"),
            _grupo("Quimica", "clase virtual"),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AltaClase()),
          );
        },
        backgroundColor: Color(Elementos.contenedor),
        child: Icon(Icons.add),
      ),
    );
  }
}
