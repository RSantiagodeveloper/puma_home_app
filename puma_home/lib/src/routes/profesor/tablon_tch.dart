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

class TablonAnunciosTch extends StatefulWidget {
  final String idGroup;
  TablonAnunciosTch(this.idGroup);

  _TablonAnunciosTchState createState() {
    return _TablonAnunciosTchState(idGroup);
  }
}

class _TablonAnunciosTchState extends State<TablonAnunciosTch> {
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
        Column(
          children: <Widget>[
            Text('Estoy en el Grupo $_idGrupo'),
            Text(
              'Tablon de Anuncios',
              style: TextStyle(fontSize: 30.0),
            ),
            Container(
              width: _width / 1.2,
              height: (_width < _height) ? _height / 3.03 : _height / 2,
              padding: EdgeInsets.all(_sizepadding),
              decoration: BoxDecoration(
                  border:
                      Border.all(width: Elementos.widthBorder, color: Color(Elementos.bordes)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(Elementos.contenedor)),
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
                              notice = newNotice
                                  .text; //guarda el cambio-> este se va a la DB
                              newNotice.text = ''; //limpia el campo de texto
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
