//@David Guerrero
//Pantalla que contiene el formulario que crea un nuevo grupo

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AltaClase extends StatefulWidget {
  final String iduser;
  AltaClase(this.iduser);
  _AltaClaseState createState() => _AltaClaseState(iduser);
}

class _AltaClaseState extends State<AltaClase> {
  String iduserState;
  _AltaClaseState(iduserState);
  final dbReference = Firestore.instance;

  TextEditingController _codigoController = TextEditingController();

  String rolUser = 'Estudiante';

  GlobalKey<FormState> _keyForm = GlobalKey();

  void initState() {
    super.initState();
    print('$iduserState');
  }
/*
* Widget responsivo que contiene un campo de texto obligatorio para introducir la claver del grupo al que
* se desea inscribir. 
*/
  Widget codeClassInput() {
    return Container(
      width: (MediaQuery.of(context).size.width <
              MediaQuery.of(context).size.height)
          ? MediaQuery.of(context).size.width / 1.25
          : MediaQuery.of(context).size.width / 2,
      height: (MediaQuery.of(context).size.width <
              MediaQuery.of(context).size.height)
          ? MediaQuery.of(context).size.height / 6.67
          : MediaQuery.of(context).size.height / 5,
      padding: EdgeInsets.all(5.0),
      margin: (MediaQuery.of(context).size.width <
              MediaQuery.of(context).size.height)
          ? EdgeInsets.only(bottom: 20)
          : EdgeInsets.only(bottom: 5),
      child: TextFormField(
        controller: _codigoController,
        decoration: InputDecoration(
          labelText: 'Id_Grupo',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Rellenar campo obligatorio';
          }
          return null;
        },
      ),
    );
  }
/*
* Widget que realiza el regisro del alumno al gupo y muestra un boton responsivo para registrarse.
*/
  Widget createButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.height / 7.67,
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FlatButton(
        child: Text(
          'Registrarse',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          if (_keyForm.currentState.validate()) {
            print('Recibi ${_codigoController.text}');
            final usuario = FirebaseAuth.instance;
            final rescate = await usuario.currentUser();
            FirebaseUser conejo = rescate;
            final resp = await dbReference
                .collection('Grupo')
                .document(_codigoController.text)
                .get();
            Map<String, dynamic> datos = resp.data;
            print('respuesta: ${resp.exists}');
            if (resp.exists != false) {
              //en caso de que falle por null, aqui es donde está meter try catch
              dbReference.collection('Grupo_Alumno').add({
                'Grupo_id': resp.documentID,
                'Alumno_id': conejo.uid,
                'Aviso': '',
                'NombreGrupo': datos['Nombre'],
                'Profesor_Id': datos['Clave_Profesor']
              });
              statusMessage('Completado', 'Has sido Registrado en el Grupo');
              _codigoController.text = '';
              //Navigator.pop(context);
            } else {
              statusMessage(
                  'Error', 'No exite el Grupo que buscas. Verifica los datos');
            }
          }
        },
      ),
    );
  }
/*
* Funcion que crea un mensaje en forma de AlerDialog para informar si la operacion de registro se realizó con exito.
*/
  void statusMessage(String opStat, String mensaje) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(Icons.check, color: Colors.green),
                Text('$opStat'),
              ],
            ),
            content: Text(
              '$mensaje', 
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              //mainAxisAlignment: MainAxisAlignment.end,
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: Colors.blue),
                  ),
                  padding: EdgeInsets.all(1.0),
                  child: Text('Aceptar', style: TextStyle(color: Colors.blue)),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppStdn(iduserState),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Alta de Clases',
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: Form(
        key: _keyForm,
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                codeClassInput(),
                createButton(context),
              ],
            )),
      ),
    );
  }
}
