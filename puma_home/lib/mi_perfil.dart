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

  double _height = 50;
  var colorElements = 0xFF040367;
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: _height,
                  padding: EdgeInsets.all(4.0),
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
                  height: _height,
                  padding: EdgeInsets.all(4.0),
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
                  height: _height,
                  padding: EdgeInsets.all(4.0),
                  child: TextField(
                    controller: usrphone,
                    decoration: InputDecoration(
                        labelText: 'Telefono de Contacto',
                        icon: Icon(Icons.phone, color: Color(colorElements)),
                      ),
                  ),
                ),
            ])),
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
      ),
    );
  }
}
