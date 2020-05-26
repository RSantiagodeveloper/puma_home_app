import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:flutter/cupertino.dart';



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
 
  final _keyForm = GlobalKey<FormState>();
  TextEditingController usrname = new TextEditingController(text: 'Nombre de Ususario');
  TextEditingController usrmail = new TextEditingController(text: 'usuario@correo.contacto');
  TextEditingController usrphone = new TextEditingController(text: 'tel-user');




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
          icon: Icon(Icons.phone, color: Color(Elementos.contenedor)),
        ),
      ),
    );
  }

  Widget createGuardarButton(){
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 4.67,
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
                 String nombre = usrname.text;
                 String email = usrmail.text;
                 String phone = usrphone.text;

                 Scaffold.of(context).showSnackBar(
                   SnackBar(content: Text('Recibi $nombre $email y $phone')));
                }
        ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(),
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
          child: ListView(
          children: [
            createNombreUsuarioInput(),
            Divider(),
            createCorreoInput(),
            Divider(),
            createTelefonoInput(),
            Divider(),
            createGuardarButton(),
            Divider(),
          ],
          )
        ),
      ),
    );
  }








}
