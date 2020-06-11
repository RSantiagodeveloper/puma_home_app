/*
 * Hasta este punto Tengo ya una version inicial del tablero.
 * Falta mejorar la responsividad del mismo, y alomejor mejorar el tema.
 * La funcionalidad basica ya esta.
 * Solo faltaria agregar una mas que se encargue de ocultar el campo de texto
 * cuando tengamos logeado a un alumno
 * 
 * Para integrarlo a tu pantalla solo hay que mandar a llamar el contructor
 * TablonAnuncios()
 * en el lugar donde lo vas a acomodar fijate en RutaEjemplo.dart
 */

import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TablonAnunciosTch extends StatefulWidget {
  final String idGroup;
  TablonAnunciosTch(this.idGroup);

  _TablonAnunciosTchState createState() {
    return _TablonAnunciosTchState(idGroup);
  }
}

class _TablonAnunciosTchState extends State<TablonAnunciosTch> {
  final dbReference = Firestore.instance;

  String _idGrupo;
  _TablonAnunciosTchState(this._idGrupo);

  String notice = 'Nueva Noticia generada y consultada desde Firebase';
  TextEditingController newNotice = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    var _sizepadding = 5.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: _width / 1.2,
          height: (_width < _height) ? _height / 3.03 : _height / 2,
          padding: EdgeInsets.all(_sizepadding),
          decoration: BoxDecoration(
              border: Border.all(
                  width: Elementos.widthBorder, color: Color(Elementos.bordes)),
              borderRadius: BorderRadius.circular(20),
              color: Color(Elementos.contenedor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder(
                  stream: dbReference.collection('Avisos').where('Id_Grupo', isEqualTo: _idGrupo).orderBy('Fecha', descending: true).snapshots(), //orderBy() ordena por fecha los avisos
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        flex: 2,
                        child: ListView(
                          children: snapshot.data.documents.map((document)
                            {return ListTile(
                                leading: Icon(
                                  Icons.chat_bubble,
                                  color: Colors.white,
                                ),
                                title: Text('${document['Notice']}', style: TextStyle(color: Colors.white)),
                              );}
                          ).toList(),
                        ),
                      );
                    } else {
                      return Text("No hay datos");
                    }
                  }),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: (_width < _height)
                          ? MediaQuery.of(context).size.width / 1.78
                          : MediaQuery.of(context).size.width / 1.5,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: TextField(
                          controller: newNotice,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.announcement,
                              color: Color(Elementos.contenedor),
                            ),
                            border: OutlineInputBorder(),
                          )),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          var fecha = new DateTime.now(); 
                          try {
                            //final resp =
                                await dbReference.collection('Avisos').add({
                              'Id_Grupo': _idGrupo,
                              'Notice': newNotice.text,
                              'Fecha': fecha, //inserta fecha actual con zona horaria
                            });
                          } catch (e) {
                            print("Errozote prro!!!!!!!!: " + e);
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
