import 'package:flutter/material.dart';
import 'package:puma_home/loginPage.dart';

class Caratula extends StatefulWidget{
  _CaratulaState createState() => _CaratulaState();
}

class _CaratulaState extends State<Caratula>{
  
  void initState(){
    Future.delayed(
      Duration(seconds: 5),
      (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    );
  }

  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Puma_Home',
      home: Scaffold(
        backgroundColor: Color(0xFF040367), //color de fondo para esta pantalla
        body: SafeArea(
          child: Center(
            child: Text(
              'Puma_Home',
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
