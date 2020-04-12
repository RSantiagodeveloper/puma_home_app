import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';

class MiPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Mi Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      drawer: MenuApp(),
      body: FormMiPerfil(),
    );
  }
}

class FormMiPerfil extends StatefulWidget {
  FormMiPerfilState createState() {
    return FormMiPerfilState();
  }
}

class FormMiPerfilState extends State<FormMiPerfil> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usrname = new TextEditingController();
  TextEditingController usrmail = new TextEditingController(); 
  TextEditingController usrphone = new TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 35.0,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlue, blurRadius: 5)
                  ]),
              child: TextFormField(
                controller: usrname,
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle, color: Colors.blue),
                    hintText: 'Nombre de Usuario'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 35.0,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlue, blurRadius: 5)
                  ]),
              child: TextFormField(
                controller: usrmail,
                decoration: InputDecoration(
                    icon: Icon(Icons.contact_mail, color: Colors.blue),
                    hintText: 'Correo de Contacto'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 35.0,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlue, blurRadius: 5)
                  ]),
              child: TextFormField(
                controller: usrphone,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone, color: Colors.blue),
                    hintText: 'Telefono de Contacto'),
              ),
            ),
            RaisedButton(
              child: Text(
                'Guardar cambios',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0
                ),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
              ),
              onPressed: () {
                String nombre = usrname.text;
                String email = usrmail.text;
                String phone = usrphone.text;

                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Recibi $nombre $email y $phone')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
