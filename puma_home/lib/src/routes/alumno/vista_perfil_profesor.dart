/*
 * Pantalla en la que el alumno pude visualizar el perfil del profesor
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VistaPerfil extends StatefulWidget {
  final String idUser;
  final String idProfe;
  VistaPerfil(this.idUser, this.idProfe);
  VistaPerfilState createState() {
    return VistaPerfilState(idUser, idProfe);
  }
}

class VistaPerfilState extends State<VistaPerfil> {
  String idUserState;
  String idProfeState;
  VistaPerfilState(this.idUserState, this.idProfeState);
  final dbReference = Firestore.instance;
  final bdRef = Firestore.instance;

  Widget build(BuildContext context) {
    print(idProfeState);
    return Scaffold(
        drawer: MenuAppStdn(idUserState),
        appBar: AppBar(
          backgroundColor: Color(Elementos.contenedor),
          title: Text('Perfil del profesor',
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
          //Se obtiene el documento en el que están guardados los datos del profesor a consultar
          future: dbReference.collection('Usuarios').document(idProfeState).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> datos = snapshot.data.data;
              return Card(
                child: Column(children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.account_circle,
                          color: Color(Elementos.contenedor)),
                      title: Text('${datos['UsrName']}')),
                  ListTile(
                      leading: Icon(Icons.contact_mail,
                          color: Color(Elementos.contenedor)),
                      title: Text('${datos['EmailContacto']}')),
                  ListTile(
                      leading:
                          Icon(Icons.phone, color: Color(Elementos.contenedor)),
                      title: Text('${datos['PhoneContacto']}')),
                ]),
              );
            } else {
              return CircularProgressIndicator(strokeWidth: 10);
            }
          },
        ));
  }
}
