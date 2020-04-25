import 'package:flutter/material.dart';
import 'MenuApp.dart';
import 'iconAppBar.dart';

class AltaClase extends StatelessWidget {
  final int bgColor = 0xFF040367;
  final int borderColor = 0xFFBEAF2A;
  final double widthBorder = 5.0;



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
  Widget createLoginButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width/1.2,
        height: MediaQuery.of(context).size.height/6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
                  border: Border.all(width: widthBorder, color: Color(borderColor)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(bgColor)),
      child: FlatButton(
        textColor: Colors.white,
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
            Divider(),
            createLoginButton(context),
          ],
        )
        
      ),
    );
  }
}