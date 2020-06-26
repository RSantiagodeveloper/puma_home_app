/*
* Pantalla que muestra el perfil del profesor.
*/
import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FormMiPerfil extends StatefulWidget {
  final String idUser;
  FormMiPerfil(this.idUser);
  FormMiPerfilState createState() {
    return FormMiPerfilState(idUser);
  }
}

class FormMiPerfilState extends State<FormMiPerfil> {
  
  String idUserState;
  FormMiPerfilState(this.idUserState);
  final dbReference = Firestore.instance;
 
  final _keyForm = GlobalKey<FormState>();
  TextEditingController usrname = new TextEditingController();
  TextEditingController usrmail = new TextEditingController();
  TextEditingController usrphone = new TextEditingController();

  @override
  void initState(){
    super.initState();
    dbReference.collection('Usuarios').document(idUserState).get().then((DocumentSnapshot ds){
      Map<String, dynamic> valor = ds.data;
      usrname.text = valor['UsrName'];
      usrmail.text = valor['EmailContacto'];
      usrphone.text = valor['PhoneContacto'];
    });
  }

//Widget para crear un nombre de usuario
  Widget createNombreUsuarioInput() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.67,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: usrname,
        decoration: InputDecoration(
          labelText: 'Nombre de Usuario',
          icon: Icon(Icons.account_circle, color: Color(Elementos.contenedor)),
        ),
      ),
    );
  }

//Widget para ingresar de manera opcional otro correo de contacto.
  Widget createCorreoInput(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.67,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: usrmail,
         decoration: InputDecoration(
           labelText: 'Correo de Contacto',
           icon: Icon(Icons.contact_mail, color: Color(Elementos.contenedor)),
        ),
      ),
    );
  }

//Widget para ingresar de manera opcional un número de teléfono.
  Widget createTelefonoInput(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.67,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: usrphone,
        decoration: InputDecoration(
          labelText: 'Telefono de Contacto',
          hintText: '(opcional) Agrega tu numero',
          icon: Icon(Icons.phone, color: Color(Elementos.contenedor)),
          
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      ),
    );
  }

//Widget que es el botón para guardar los cambios.
  Widget createGuardarButton(){
    return Container(
      width: MediaQuery.of(context).size.width / 3.33,
      height: MediaQuery.of(context).size.height / 10,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration( 
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FloatingActionButton.extended(
               icon: Icon(Icons.check_circle_outline),
               label: Text('Guardar'),
               backgroundColor: Color(Elementos.contenedor),
               onPressed: () {
                 try{
                   dbReference.collection('Usuarios').document(idUserState).updateData({
                    'UsrName': usrname.text,
                    'EmailContacto': usrmail.text,
                    'PhoneContacto': usrphone.text
                   });
                 }catch(e){
                  print(e.toString());
                 }
                 _infoDialog('Datos Actualizados');
                }
        ),
    );
  }

//Mensaje emergente que sale después de presionar el botón de guardar
  void _infoDialog(String mensaje) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('info'),
            content: Text(
              '$mensaje',
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: GestureDetector(
                    child: Text(
                      'Aceptar',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ))
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(idUserState),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Mi perfil', 
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
          child: ListView(
          children: [
            createNombreUsuarioInput(),
            Divider(),
            createCorreoInput(),
            Divider(),
            createTelefonoInput(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                createGuardarButton(),
              ],
            ),
            Divider(),
          ],
          )
        ),
      ),
    );
  }
}
