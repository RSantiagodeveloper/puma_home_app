import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

class MiPerfilTch extends StatelessWidget {
  final String idUser;
  MiPerfilTch(this.idUser);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(Elementos.btnMiPerf),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      drawer: MenuAppTch(),
      body: FormMiPerfil(idUser),
    );
  }
}

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

  var colorElements = 0xFF040367;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usrname =
      new TextEditingController(text: 'Nombre de Ususario');
  TextEditingController usrmail =
      new TextEditingController(text: 'usuario@correo.contacto');
  TextEditingController usrphone = new TextEditingController(text: 'tel-user');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.67,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: usrname,
              decoration: InputDecoration(
                labelText: 'Nombre de Usuario',
                icon: Icon(Icons.account_circle, color: Color(colorElements)),
              ),
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.67,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: usrmail,
              decoration: InputDecoration(
                labelText: 'Correo de Contacto',
                icon: Icon(Icons.contact_mail, color: Color(colorElements)),
              ),
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.67,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: usrphone,
              decoration: InputDecoration(
                labelText: 'Telefono de Contacto',
                icon: Icon(Icons.phone, color: Color(colorElements)),
              ),
            ),
          ),
          Divider(),
          FloatingActionButton.extended(
            icon: Icon(Icons.check_circle_outline),
            label: Text('guardar'),
            backgroundColor: Color(colorElements),
            onPressed: () {
              String nombre = usrname.text;
              String email = usrmail.text;
              String phone = usrphone.text;

              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Recibi $nombre $email y $phone')));
            },
          ),
        ],
      ),
    );
  }
}
