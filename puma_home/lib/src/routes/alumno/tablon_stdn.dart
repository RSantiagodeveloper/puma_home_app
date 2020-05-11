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

class TablonAnunciosStdn extends StatefulWidget {
  final String idGroup;
  TablonAnunciosStdn(this.idGroup);
  _TablonAnunciosStdnState createState() {
    return _TablonAnunciosStdnState(idGroup);
  }
}

class _TablonAnunciosStdnState extends State<TablonAnunciosStdn> {
  String _idGrupo;
  _TablonAnunciosStdnState(this._idGrupo);

  String notice = 'Nueva Noticia generada y consultada desde Firebase';
  TextEditingController newNotice = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    var bgColor = 0xFF040367;
    var borderColor = 0xFFBEAF2A;
    var widthBorder = 5.0;
    var _sizepadding = 5.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
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
                      Border.all(width: widthBorder, color: Color(borderColor)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(bgColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    notice,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
