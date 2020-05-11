/**
 * En este archivo se define la pantalla correspondiente a los grupos en los que un alumno está incrito.
 * 
 */
import 'package:flutter/material.dart';
import 'package:puma_home/MenuApp.dart';
import 'package:puma_home/addgrupo.dart';


class MisGrupos extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
}


///este widget devuelve la tarjeta individual para cada grupo
///se le tiene que pasar un string nombre para que la pueda mostrar

Widget _grupo(String nombre , String tipoClase) {
  return Card(
    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),  
    color: Colors.blue,
    child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.class_),
          title:  Text(nombre),
          subtitle: Text(tipoClase),

        )
      ],
    )
  );
}

///funcion que obtiene los datos de firebase para los grupos
generarGrupo(){
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
          color: Colors.blue,
          child: Text('Mis Grupos'),
        ),
      ),
      drawer: MenuApp(),
      body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: [
            generarGrupo(),
            _grupo("Historia","clase virtual"),
            _grupo("Matematicas","clase prensencial"),
            _grupo("Quimica","clase virtual"),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addgrupo()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
