import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';

class AltaClase extends StatelessWidget {


  Widget createCodigoInput() {
    return Padding(
              padding: const EdgeInsets.only(
                top: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Código'
                ),
                obscureText: true,
              ),
            );
  }
  Widget createLoginButton() {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text('Darse de alta'),
      onPressed: () {},
      )
      );
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MenuApp(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Inscripción'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: IconAppBar(),//metodo donde se crea la referencia al icono
            onPressed: null
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: ListView(
          children: [
            createCodigoInput(),
            createLoginButton(),
          ],
        )
        
      ),
    );
  }
}