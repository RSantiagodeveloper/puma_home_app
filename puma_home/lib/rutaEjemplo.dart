import 'package:flutter/material.dart';

class RutaEjemplo extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => print('menu'),
            );
          },
        ),
        backgroundColor: Colors.blue,
        title: Text('titulo de pantalla'),
        actions: [IconButton(
          icon: Icon(Icons.android),
          onPressed: (){}
        )]
      ),
      body: Center(
        child: Text('Aqui van los formularios'),
      ),
    );
  }
}

