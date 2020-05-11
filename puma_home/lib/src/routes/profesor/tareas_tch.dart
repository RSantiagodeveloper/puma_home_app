import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';

class TareasTch extends StatefulWidget {
  @override
  _TareasState createState() => _TareasState();
}

seleccionarColor(materia) {
  var sistemasOperativos = "sistemas operativos";
  if (materia == sistemasOperativos) {
    return Colors.blue;
  } else if (materia == "ecuaciones diferenciales") {
    return Colors.green;
  } else if (materia == "analisis de sistemas y señales") {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}

Widget _tarea(nombre, clase, entrega) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: seleccionarColor(clase),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fiber_new),
            title: Text(nombre),
            subtitle: Text(clase + "\n" + "Entrega: " + entrega),
            isThreeLine: true,
            onTap: () {},
          )
        ],
      ));
}

class _TareasState extends State<TareasTch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: () {})
        ],
        title: Title(
          color: Colors.blue,
          child: Text('Tareas Pendientes'),
        ),
      ),
      drawer: MenuAppTch(),
      body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: [
            //aqui se crean las tarjetas de las tareas
            _tarea("reporte tema 2", "sistemas operativos", "03/09/22"),
            _tarea("serie 1", "ecuaciones diferenciales", "12/03/22"),
            _tarea("reporte tema 2", "sistemas operativos", "03/09/22"),
            _tarea(
                "reporte tema 1", "analisis de sistemas y señales", "03/09/22"),
            _tarea("chistes de pepito", "sistemas operativos", "03/09/22"),
            _tarea(
                "reporte tema 2", "analisis de sistemas y señales", "03/09/22"),
          ]),
    );
  }
}
