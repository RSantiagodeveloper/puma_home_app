import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/routes/profesor/pantalla_Grupo_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/routes/profesor/formulario_alta_clases.dart';

class MisGruposTch extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
}
/// widget que devuelve una tarjeta. Esta contiene la informacion de un grupo
/// parametro nombre recibe el nombre de la clase
/// Icon.delete
Widget _grupo(BuildContext context, String nombre) {
  return Card(
      margin: EdgeInsets.all(10.0), 
      color: Color(Elementos.contenedor),
      child: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.class_),
            title: Text('Clase '),
            //subtitle: Text('Profesor ')
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('Detalles'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PantallaGrupoTch('userX', 'grpY')));
                }
              ),
              FlatButton(
                child: 
                  //Icon(Icons.delete),
                  Text('Borrar'),
                onPressed: () {/*borrar*/},
              ),
            ],
          ),
        ],
      ));
}

class _MisGruposState extends State<MisGruposTch> {
  ///referencia a la base de datos de firebase
  final fireReference = Firestore.instance;
  List<String> groups=[];

 // Map<String, dynamic> valor;
   // var data = await fireReference.collection('Mis').where("idteacher",isEqualTo:iduser).getDocuments().snapshots().listen((result){
     // valor = result.data;
       // groups.add(valor['NombreClase']);
     // });
    //});
 // }

  //Future<void> DelateGroup(String iduser, String nombreMat) async {
    //var erase = await fireReference.collection('MisGrupos').where("idteacher",isEqualTo:iduser).where("nombreClase",isEqualTo:nombreMat).delete();
  //}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Color(Elementos.contenedor),
          child: Text('Mis Grupos'),
        ),
      ),
      drawer: MenuAppTch(),
      ///aqui se crean las tarjetas para las clases
      body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: [
           _grupo(context, "Historia"), 
           _grupo(context, "Matematicas"),
           _grupo(context, "Quimica"),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {   
         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormularioAltaClase())); //aqui va la llamada a la pantalla formulario_alta_clases
        },
        backgroundColor: Color(Elementos.contenedor),
        child: Icon(Icons.add),
      ),
    );
  }
}


///ricardo
///hanibal
///angel
///espejel
///todos ellos en esta pantalla
///
///
///
///
/*Widget _grupo(BuildContext context, String nombre) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Color(Elementos.contenedor),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: IconButton(
                icon: Icon(Icons.class_),   
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PantallaGrupoTch('userX', 'grpY')));
                }),
            title: Text(nombre),
            subtitle: Text("clase virtual"),
          )
        ],
      ));
}
*/