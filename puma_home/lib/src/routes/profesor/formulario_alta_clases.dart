/*
 * Pantalla en la solo el profesor puede crear un nuevo grupo
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';


class FormularioAltaClase extends StatefulWidget{

  FormularioAltaClaseState createState() {
    return FormularioAltaClaseState();
  }
}

class FormularioAltaClaseState extends State<FormularioAltaClase>{


  //Referencia a la base de datos en firestore
  final dbReference = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  TextEditingController _nombreclase = new TextEditingController();
  TextEditingController _claveGrupo = new TextEditingController();
  GlobalKey<FormState> keyForm = new GlobalKey();

//Widget en el que se inserta el nuevo nombre del grupo a crear
  Widget createNombreClaseInput() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6.67,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _nombreclase,
        decoration: InputDecoration(
          labelText: 'Inserta el nombre de la clase',
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

//widget de la clave del grupo 
  Widget claveGrupo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6.67,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _claveGrupo,
      ),
    );
  }

//Widget que recupera esa clave que genera Firebase
  Widget botonGenerar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6.67,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(Elementos.contenedor),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 5, color: Color(Elementos.bordes))
      ),
      margin: EdgeInsets.only(top: 10),
      child: FlatButton(
        child: Text(
          'Registrar y generar clave',
           style: TextStyle(color: Colors.white),          
          ),
          onPressed: () async {
            if(keyForm.currentState.validate()){
              /*Aqui se teienen que insertar los datos en el cloud y ademas se rescata el id de registro*/
              //-paso 1, referencia a la coleccion Grupo
              //-paso 2, a??adir datos en un nuevo documento
                //-Nombre de grupo
                //-UID profesor <- currentUser()
              //rescatar el ID del Documento a??adido
              //ID Mostrarlo en la app (Fines demostrativos)

              //TODO: implementar un metodo que genere una clave unica para no usar el ID_doc
              print('Nombre de clase: ${_nombreclase.text}');
              
              //se crea el current user (antes se tiene que esperar la respuesta (await))
              final result = await _auth.currentUser();
              FirebaseUser usuario = result;

              dbReference.collection('Grupo').add({
                'Nombre': _nombreclase.text,
                'Clave_Profesor': usuario.uid
              }).then((value) {
                _claveGrupo.text = value.documentID;
              });
              
            }
          },
      )
    );
  }

//Widget para regresar a la pantalla de grupos del profesor
  Widget createReturnButton(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 6.67,
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))
      ),
      child: FlatButton(
        child: Text(
          'Mis grupos',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
            Navigator.pop(context);
        },
      )
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Alta de clases', 
        style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: Form(
       key: keyForm,

       child: Container(
          padding: const EdgeInsets.all(20),
          child: new ListView(
            children: <Widget>[
              createNombreClaseInput(),
              Divider(),
              claveGrupo(),
              Divider(),
              botonGenerar(),
              Divider(),
              createReturnButton(context)              
            ],

       ),

      ),
      

    ));
  }


}