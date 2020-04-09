import 'package:flutter/material.dart';
import 'package:puma_home/misgrupos.dart';
class Caratula extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Puma_Home',
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent[100], //color de fondo para esta pantalla
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
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
              Center(
                child: RaisedButton(
                  child: Text('iniciar'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MisGrupos()),
                    );
                  },                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
