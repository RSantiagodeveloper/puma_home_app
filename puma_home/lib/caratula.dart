import 'package:flutter/material.dart';

class Caratula extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Puma_Home',
      home: Scaffold(
        body: Center(
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
      backgroundColor: Colors.lightBlueAccent[100],
      ),
    );
  }
}