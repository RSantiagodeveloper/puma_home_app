import 'package:flutter/material.dart';
import 'package:puma_home/src/Inicio.dart'; ///Caratura(),
import 'package:puma_home/src/routes/servicios/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puma Home',
      home: LoginPage(),
    );
  }
}

//comentario de prueba