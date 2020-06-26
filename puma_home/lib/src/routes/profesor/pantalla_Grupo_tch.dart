/*
 * Pantalla de grupo del profesor;
 * Aqui solo se Mandan a llamar al Tablon de anuncios con las funcionalidades
 * para publicar noticias, Acceder al listado de tareas para este grupo, asi como
 * el Material de apoyo que muestra los archivos disponibles del Storage
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/profesor/tareas.dart';
import 'package:puma_home/src/routes/profesor/material_Apoyo_tch.dart';
import 'package:puma_home/src/routes/profesor/tablon_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

//ignorar warning: Tiene que ver con el TextEditingControler que no esta declarado como final,
//aun asi funciona
class PantallaGrupoTch extends StatelessWidget {
  final String idUser; //id del usuario actual
  final String idGroup; //id del Grupo Actual
  final String nombreGrupo;
  PantallaGrupoTch(this.idUser, this.idGroup, this.nombreGrupo);
  final TextEditingController newNotice = new TextEditingController();

  //boton de acceso a tareas
  Widget createTareasButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(
                width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Tareas'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Tareastch(idUser, idGroup)),
            );
          },
        )
      );
  }

  //Boton de acceso a Material de Apoyo
  Widget createMaterialButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(
                width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Material de apoyo'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MaterialApoyoTch(idUser, idGroup)),
            );
          },
        ));
  }
  /*
   * Metodo que crea el widgen encargado de recibir el texto escrito por el profesor
   * y que al momento de atender un evento onPressed en el IconButton, se conecta
   * a FireStore y guarda la noticia en el registro correspondiente
   */

  Widget cajaMensajes(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: (_width < _height)
                ? MediaQuery.of(context).size.width / 1.78
                : MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(color: Colors.white),
            child: TextField(
                maxLength: 150,
                scrollController: ScrollController(
                    initialScrollOffset: 0.0, keepScrollOffset: false),
                controller: newNotice,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.announcement,
                    color: Color(Elementos.contenedor),
                  ),
                )),
          ),
          IconButton(
              icon: Icon(
                Icons.send,
                color: Color(Elementos.contenedor),
              ),
              onPressed: () async {
                var fecha = new DateTime.now();
                try {
                  //Creacion de registros en la Coleccion avisos. Cada docuemnto
                  //Tiene clave unica y esta asociada al grupo a travez de su idGroup
                  await Firestore.instance.collection('Avisos').add({
                    'Id_Grupo': idGroup,
                    'Notice': newNotice.text,
                    'Fecha': fecha, //inserta fecha actual con zona horaria
                  }).then((value){
                    newNotice.text=''; //Limpieza del TextField
                  });
                } catch (e) {
                  print("Errozote prro!!!!!!!!: " + e);
                }
              }),
        ],
      ),
    );
  }

  //constructor de la pantalla.
  //Aqui solo estamos indicandole a Flutter como acomodar los Widgets
  //en el scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(idUser),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('$nombreGrupo',
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              TablonAnunciosTch(idGroup),
              Divider(),
              cajaMensajes(context),
              Divider(),
              createTareasButton(context),
              Divider(),
              createMaterialButton(context),
            ],
          )),
    );
  }
}
