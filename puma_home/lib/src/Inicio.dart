/*
 * 
 * codigo que hace la splash screen provisional
 * eventualmente será descartado
 */


import 'package:flutter/material.dart';
import 'package:puma_home/src/routes/servicios/loginPage.dart';

class Caratula extends StatefulWidget{
  _CaratulaState createState() => _CaratulaState();
}

class _CaratulaState extends State<Caratula>{

  void initState(){
    super.initState();//bien magico el richi boss
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/logos/lanzador_app3.png'),
                SizedBox(
                  height:10,
                ),
                Text(
              'Puma_Home',
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
              ]
            )
          ),
        ),
      ),
    );
  }
}
