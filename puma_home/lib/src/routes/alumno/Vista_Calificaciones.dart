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

  Widget mostrarComentario(String texto) {
    return Text(
      '$texto',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      textAlign: TextAlign.justify,
    );
  }

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

  Widget mostrarResultados(AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
        children: snapshot.data.documents.map((document) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
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
                                  title: (document['Comentario'] != '')
                                      ? mostrarComentario(
                                          document['Comentario'])
                                      : mostrarComentario(
                                          'No hagregadó comentarios'),
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
                                  title: (document['Comentario_Profe'] != '')
                                      ? mostrarComentario(
                                          document['Comentario_Profe'])
                                      : mostrarComentario(
                                          'No Hay Comentarios del Profesor'),
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
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text("Calificacion"),
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
            .where('Id_Tarea', isEqualTo: idTarea)
            .where('Id_Alumno', isEqualTo: idUser)
            .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print('Lista Vacia?${snapshot.data.documents.isEmpty}');
          print('elementos?${snapshot.data.documents.length}');
          print('ID_Docum?${snapshot.data.documents[0].documentID}');
          if (!snapshot.hasData) {
            return sinRegistro();
          } else {
            return mostrarResultados(snapshot);
          }
        },
      ),
    );
  }
}
/* 

Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
                      child: Text('Caja de comentarios',
                          style: TextStyle(
                            fontSize: 17,
                          )),
                    ),
Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  // color: Color(Elementos.contenedor),
                                                  border: Border.all(
                                                    color:
                                                        Color(Elementos.bordes),
                                                    width: 5,
                                                  )),
                                              child: ListTile(
                                                title: (datos['Comentario'] !=
                                                        '')
                                                    ? mostrarComentario(
                                                        datos['Comentario'])
                                                    : mostrarComentario(
                                                        'No has agregado comentarios'),
                                              ),
                                            ),
                                          ),
                                        ]),
                                    SizedBox(height: 15),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color:
                                                        Color(Elementos.bordes),
                                                    width: 5,
                                                  )),
                                              child: ListTile(
                                                title: (datos[
                                                            'Comentario_Profe'] !=
                                                        '')
                                                    ? mostrarComentario(datos[
                                                        "Comentario_Profe"])
                                                    : mostrarComentario(
                                                        'No Hay Comentarios del Profesor'),
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

                    /*
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 10,
                                child: TextFormField(
                                  controller: calificacion,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    labelText: 'Calificación',
                                    icon: Icon(Icons.check)
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Rellenar campo obligatorio';
                                    } else if (double.parse(value) < 0 ||
                                        double.parse(value) > 10) {
                                      return 'calificacion invalida';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11.0),
                                    side: BorderSide(
                                      color: Color(Elementos.bordes),
                                      width: 3,
                                    )),
                                color: Color(Elementos.contenedor),
                                onPressed: () {
                                  if (keyFormulario.currentState.validate()) {
                                    Firestore.instance
                                        .collection('Tarea_Alumno')
                                        .document(idTarea)
                                        .updateData({
                                      'Comentario_Profe': comentarioAlumno.text,
                                      'Calificacion':
                                          double.parse(calificacion.text),
                                      'Calificado': 1,
                                    }).then((value) {
                                      comentarioAlumno.text = '';
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: Text(
                                  'Enviar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                         */ */
