// Pantall donde el alumno puede ver los cometarios del profesor sobre su tarea, responder y ver su calificacion.
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';

class VistaCalificaciones extends StatefulWidget {
  final String idGrupo;
  final String idTarea;
  final String idUser;
  VistaCalificaciones(this.idGrupo, this.idTarea, this.idUser);
  @override
  _VistaCalificacionesState createState() =>
      _VistaCalificacionesState(idGrupo, idTarea, idUser);
}

class _VistaCalificacionesState extends State<VistaCalificaciones> {
  String idGrupo;
  String idTarea;
  String idUser;
  _VistaCalificacionesState(this.idGrupo, this.idTarea, this.idUser);

  Widget mostrarComentario(String texto, double sizeText, Color colorText) {
    return Text(
      '$texto',
      style: TextStyle(fontSize: sizeText, color: colorText),
      textAlign: TextAlign.justify,
    );
  }

//Si no hay archivo, entonces no tendrá nada que mostrar
  Widget sinRegistro() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1765,
        height: MediaQuery.of(context).size.height / 4,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color(Elementos.contenedor),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Color(Elementos.bordes),
              width: 5,
            )),
        child: Text(
          'Aún no has realizado la entrega',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
// muestra la calificacion si se a
  Widget mostrarResultados(
      String comentAl, String comentProf, var calificacion, var statusCalif) {
    return ListView(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width / 1.1765,
            height: MediaQuery.of(context).size.height / 4,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color(Elementos.contenedor),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Color(Elementos.contenedor),
                                    border: Border.all(
                                      color: Color(Elementos.bordes),
                                      width: 5,
                                    )),
                                child: ListTile(
                                  leading: Icon(Icons.pets, color: Colors.white),
                                  title: (comentAl != '')
                                      ? mostrarComentario(
                                          comentAl, 18, Colors.white)
                                      : mostrarComentario(
                                          'No hagregado comentarios',
                                          18,
                                          Colors.white),
                                ),
                              ),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(Elementos.bordes),
                                      width: 5,
                                    )),
                                child: ListTile(
                                  leading: Icon(Icons.pets, color: Color(Elementos.bordes)),
                                  title: (comentProf != '')
                                      ? mostrarComentario(
                                          comentProf, 18, Colors.white)
                                      : mostrarComentario(
                                          'No Hay Comentarios del Profesor',
                                          18,
                                          Colors.white),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //Campo que muestra la Calificacion de la Tarea
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(Elementos.contenedor),
                        width: 5,
                      )),
                  child: Text('$calificacion', style: TextStyle(fontSize: 16))),
              Container(
                //campo que muestra cierto mensaje, dependiendo si ya fue calificada la tarea
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  child: (statusCalif == 0)
                      ? mostrarComentario(
                          'No ha sido calificado', 20, Colors.red)
                      : mostrarComentario(
                          'Calificacion entregada', 20, Colors.green))
            ],
          )
        ],
      )
    ]);
  }

  @override
//widget que manda a llamar a los métodos 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text("Calificacion",
       style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: FutureBuilder(
        future: Firestore.instance
            .collection('Tarea_Alumno')
            .document(idTarea)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return sinRegistro();
          } else {
            Map<String, dynamic> datos = snapshot.data.data;
            return mostrarResultados(
                datos['Comentario'],
                datos['Comentario_Profe'],
                datos['Calificacion'],
                datos['Calificado']);
          }
        },
      ),
    );
  }
}
