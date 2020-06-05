import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';


class TareasTch extends StatefulWidget {

final String idUser;
  TareasTch(this.idUser);
  _TareasState createState() {
    return _TareasState(idUser);
  }
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
      elevation:15.0,
      margin: EdgeInsets.all(10),
      //color: seleccionarColor(clase), //color asignado para diferenciar materias en la pantalla de tareas_std
      color: Color(Elementos.contenedor),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fiber_new, color: Color(Elementos.bordes),),
            title: Text(nombre, style: TextStyle(color: Color(Elementos.bordes)),),
            subtitle: Text(clase + "\n" + "Entrega: " + entrega,style: TextStyle(color: Colors.white), ),
            isThreeLine: true,
            onTap: () {},
          )
        ],
      ));
}

class _TareasState extends State<TareasTch> {
  String idUserState;
 _TareasState(this.idUserState);
@override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(idUserState),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Tareas pendientes', 
        style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),

      body: ListView(
          padding: EdgeInsets.symmetric(
            //horizontal: 16,
            //vertical: 16,
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
