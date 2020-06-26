/*
* Pantalla en la que el profesor puede descargar y ver la tarea que entregaron sus alumnos.
*/
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VistaTarea extends StatefulWidget {
  final String idUser;
  final String idTarea;
  final String url;
  VistaTarea(this.idUser, this.idTarea, this.url);
  @override
  _VistaTareaState createState() => _VistaTareaState(idUser, idTarea, url);
}

class _VistaTareaState extends State<VistaTarea> {
  String idUser;
  String idTarea;
  String url;
  _VistaTareaState(this.idUser, this.idTarea, this.url);

  TextEditingController comentarioProf = new TextEditingController();
  TextEditingController calificacion = new TextEditingController();
  GlobalKey<FormState> keyFormulario = new GlobalKey();
  bool activado = false;
  //bool _multiPick = false;
  bool downloading = false; //variables globales
  var progressString = "";

  void downloadFile(String url, String name) async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      var download = dio.download(url, "${dir.path}/" + name,
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
      await download;
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
    var path = await getApplicationDocumentsDirectory();
    print("${path.path}/");
  }

    void launchURL(url) async {
  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 
  /*Widget loadBar() {
    return Center(
      child: downloading
          ? Container(
              height: 120.0,
              width: 200.0,
              child: Card(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Downloading File: $progressString",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Text("No Data"),
    );
  }*/

  /// widget text que muestra un [texto] como comentario
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(Elementos.contenedor),
          title: Text('Calificar Tarea',
              style: TextStyle(color: Color(Elementos.bordes))),
          centerTitle: true,
          actions: [
            IconButton(
                icon:
                    IconAppBar(), //metodo donde se crea la referencia al icono
                onPressed: null)
          ],
        ),
        body: FutureBuilder(
            future: Firestore.instance
                .collection('Tarea_Alumno')
                .document(idTarea)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> datos = snapshot.data.data;
                calificacion.text = datos['Calificacion'].toString();

                return ListView(
                  children: <Widget>[
                    //Boton para bajar archivo del alumno
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(Elementos.contenedor),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 5, color: Color(Elementos.bordes))),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //loadBar(),
                          Expanded(
                            child: Container(
                              //contiene del nombre Archivo
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Archivo del Alumno',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              //Descargar archivos
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //downloadFile(datos['Archivo'],datos['Material_Apoyo']);
                                      launchURL(url);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 1, 10),
                          child: Text('Comentarios',
                              style: TextStyle(
                                fontSize: 17,
                              )),
                        ),
                      ],
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
                                                leading: Icon(Icons.pets, color: Colors.white),
                                                title: (datos["Comentario"] !=
                                                        '')
                                                    ? mostrarComentario(
                                                        datos["Comentario"])
                                                    : mostrarComentario(
                                                        'No Hay Comentarios del Alumno'),
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
                                                leading: Icon(Icons.pets, color: Color(Elementos.bordes)),
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
                    Form(
                      key: keyFormulario,
                      child: Column(
                        children: <Widget>[
                          /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.1765,
                          height: MediaQuery.of(context).size.height/4,
                          child: TextFormField(
                            controller: comentarioProf,
                            
                          ),
                        ),
                      ],
                    ),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width /
                                      1.1765,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  child: TextField(
                                    autocorrect: true,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.add_comment),
                                      labelText: 'Agregar Comentario',
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    controller: comentarioProf,
                                    maxLength: 150,
                                    scrollController: ScrollController(
                                        initialScrollOffset: 0.0,
                                        keepScrollOffset: false),
                                  )),
                            ],
                          ),
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
                                      icon: Icon(Icons.check)),
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
                                      'Comentario_Profe': comentarioProf.text,
                                      'Calificacion':
                                          double.parse(calificacion.text),
                                      'Calificado': 1,
                                    }).then((value) {
                                      comentarioProf.text = '';
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
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Cargando...'),
                );
              }
            }));
  }
}
