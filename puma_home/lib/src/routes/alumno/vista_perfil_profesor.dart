import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VistaPerfil extends StatefulWidget{
  final String idUser;
  VistaPerfil(this.idUser);
  VistaPerfilState createState() {
    return VistaPerfilState(idUser);
  }

}


class VistaPerfilState extends State <VistaPerfil>{
  String idUserState;
  VistaPerfilState(this.idUserState);
  final dbReference = Firestore.instance;

  var name1;
  var mail1;
  var phone1;
  var idtch = '879X5dPcpsQ0HqW3Yox4JanREkW2';
  void bdProf(String idprof)async{
      dbReference.collection('Usuarios').document(idprof).get().then((DocumentSnapshot ds){
          Map<String, dynamic> valor = ds.data;
          name1=valor['Nombre'];
          mail1=valor['EContactoEmailContacto'];
          phone1=valor['PhoneContactoContacto'];


      }
    );
  }


  Widget createNombre(BuildContext context){
    return Card(
        child:ListView(
            children: <Widget>[
                ListTile(
                    leading:Icon(Icons.account_circle, color: Color(Elementos.contenedor)),
                    title:Text(name1)
                ),
                 ListTile(
                    leading:Icon(Icons.contact_mail, color: Color(Elementos.contenedor)),
                    title:Text(mail1)
                ),
                 ListTile(
                    leading:Icon(Icons.phone, color: Color(Elementos.contenedor)),
                    title:Text(phone1)
                ),
            ],
        ),
    );

  }

@override
  void initState() {
    super.initState();
    bdProf(idtch);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppStdn(),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Perfil del profesor', 
        style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: Form(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
          children: [
     
            Divider(),
            createNombre(context),

          ],
          )
        ),
      ),
    );
  } 



}