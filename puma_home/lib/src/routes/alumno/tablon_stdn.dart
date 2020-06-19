/*
 * Widget Tablon de Anuncios:
 * Aqui solamente se van a mostrar lo avisos que el profesor publique para el grupo
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    var _sizepadding = 5.0;

    //Se crea el row para la parte de avisos
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
                  border: Border.all(
                      width: Elementos.widthBorder,
                      color: Color(Elementos.bordes)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(Elementos.contenedor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StreamBuilder(
                      stream: Firestore.instance.collection('Avisos').where('Id_Grupo', isEqualTo: _idGrupo).orderBy('Fecha', descending: true).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            flex: 2,
                            child: ListView(
                              children: snapshot.data.documents.map((document) {
                                return ListTile(
                                  leading: Icon(
                                    Icons.chat_bubble,
                                    color: Colors.white,
                                  ),
                                  //muestra en pantalla los avisos del profesor ordenados por fecha
                                  title: Text('${document['Notice']}' ,style: TextStyle(color: Colors.white)),
                                  subtitle: Text('${DateTime.parse(document['Fecha'].toDate().toString())}', style: TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                            ),
                          );
                        } else {
                          return Expanded(
                              child: Text(
                            "No hay avisos", 
                            style: TextStyle(color: Colors.white),
                          ));
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
