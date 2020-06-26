import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:url_launcher/url_launcher.dart'; //import del PlatformException


class VistaTareaTch extends StatefulWidget {
  final String idUser;
  final String idTarea;
  final String urlFile;
  final String descTarea;
  final String nombreTarea;
  final String idGrupo;
  final String fechaEntrega;
  VistaTareaTch(this.idUser, this.idTarea, this.nombreTarea, this.urlFile,
      this.descTarea, this.idGrupo,this.fechaEntrega);
  @override
  _VistaTareaTchState createState() => _VistaTareaTchState(
      idUser, idTarea, nombreTarea, urlFile, descTarea, idGrupo,fechaEntrega);
}

class _VistaTareaTchState extends State<VistaTareaTch> {
  String idUser;
  String idTarea;
  String urlFile;
  String descTarea;
  String nombreTarea;
  String idGrupo;
  String fechaEntrega;
  _VistaTareaTchState(this.idUser, this.idTarea, this.nombreTarea, this.urlFile,
      this.descTarea, this.idGrupo,this.fechaEntrega);

//descripcion de la tarea
//fecha de entrega

  ///decarga de archivo
  void downloadFile(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //mostrarCampo(comentario),
  //mostrarCampo(fechaEntrega),

  Widget mostrarInfoTarea(String comentario, String fecha) {
   return Container(
      width: MediaQuery.of(context).size.width / 1.1765,
      height: MediaQuery.of(context).size.height / 4,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
              width: Elementos.widthBorder, color: Color(Elementos.bordes)),
          borderRadius: BorderRadius.circular(20),
          color: Color(Elementos.contenedor)),
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.white),
            title: mostrarComentario("Descripcion: \n",comentario),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.white),
            title: mostrarComentario("Fecha de entrega: \n",fecha),
          )
        ],
      ),
    );
  }

  Widget mostrarComentario(String campo, String texto) {
    return Text(campo +
      '$texto',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget botonDescarga() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              //contiene del nombre Archivo
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Archivo de tarea',
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
                      downloadFile(urlFile);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(idUser),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Datos de la tarea', //pasarle el nombre de la tarea
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: ListView(
        children: <Widget>[
          mostrarInfoTarea(descTarea,fechaEntrega),
          Divider(),
          botonDescarga(),
        ],
      ),
    );
  }
}
