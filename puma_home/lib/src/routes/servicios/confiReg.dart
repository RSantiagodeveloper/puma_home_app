
// Pantalla que se muestra a un nuevo usuario regisrado.
import 'package:flutter/material.dart';

import '../../Inicio.dart';

class SuccessRegPage extends StatelessWidget {
  final String usuario;

  SuccessRegPage(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Card(
        child: Column(
          children: <Widget>[
            Image.asset('images/logos/card_unam.jpg'),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Bienvenido $usuario a Puma-Home App. A partir de ahora podras disfrutar de las funcionalidades que esta app tiene para ti',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
              ),
            ),
            FloatingActionButton.extended(
                icon: Icon(Icons.account_circle),
                label: Text('Iniciar Sesión '),
                backgroundColor: Color(0xFF040367),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Caratula()));
                })
          ],
        ),
      ),
    );
  }
}
