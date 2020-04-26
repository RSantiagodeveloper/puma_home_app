import 'package:flutter/material.dart';
import 'package:puma_home/Inicio.dart';
import 'package:puma_home/mi_perfil.dart';
import 'package:puma_home/pantallaGrupo_s.dart';
import 'package:puma_home/pantallagrupo.dart';
import 'package:puma_home/registro.dart';
import 'package:puma_home/rutaTest.dart';
import 'minimenu.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Menú',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(height: 70),
        textTheme: TextTheme(
          subhead: TextStyle(
            fontSize: 18,
          ),
          button: TextStyle(
            fontSize: 21
          )
        )
      ),
      //home: MiniMenu(),
      home: RegistryPage(),
    );
  }
}