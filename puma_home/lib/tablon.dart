/**
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

class TablonAnuncios extends StatefulWidget {
  _TablonAnunciosState createState() {
    return _TablonAnunciosState();
  }
}

class _TablonAnunciosState extends State<TablonAnuncios> {
  String notice = 'Nueva Noticia generada y consultada desde Firebase';
  TextEditingController newNotice = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.all(6.0),
      margin: EdgeInsets.fromLTRB(22, 20, 22, 26.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFBEAF2A)),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 3.25,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF040367)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  notice,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/1.7,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: TextField(
                        controller: newNotice,
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.announcement,
                            color: Color(0xFF040367),
                          ),
                          border: OutlineInputBorder(),
                      )),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            notice = newNotice.text; //guarda el cambio-> este se va a la DB
                            newNotice.text = ''; //limpia el campo de texto
                          });
                        }),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
