import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
TextEditingController _emailController = TextEditingController();
TextEditingController _contraController = TextEditingController();
// **** -falta tocar cosas
class LoginPage extends StatelessWidget {
  Widget crearEmail(){  //crea formato Email
    return Padding(
      padding: const EdgeInsets.only(top:40),
      child: TextFormField(
        controller: _emailController,
        decoration:InputDecoration(hintText:'Usuario o Email'),
    ),);
  }

  Widget crearContra() { //Crea formato Contraseña
    return Padding(
      padding: const EdgeInsets.only(top:32),
      child: TextFormField(
        controller: _contraController,
        decoration: InputDecoration(hintText:'Contraseña'),
        obscureText: true,
    ),);
  }

  Widget crearBoton(){ // Crea el Boton de Enviar
    return Container(padding: const EdgeInsets.only(top:32), 
    child: RaisedButton(
      child:Text('Entrar'),
      onPressed:(){/*
       FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text , password: _emailController.text).then((
          FirebaseUser user){
            Navigator.of(context).pushReplacementNamed(CupertinoPageRoute(
              builder:(context) => GooglePage(),
              ));
          }*/ 
          }, //deja el acceso en caso de ser correcto****
    ));
  }


   Widget crearLinkCuenta(){ //Crea el link al menu para registrar****
    return Container(
      padding: const EdgeInsets.only(top:6, right: 8),
      child: GestureDetector(
        child: Text("o crea tu cuenta aqui",
        textAlign: TextAlign.right,
          style: TextStyle(
             fontSize: 18, 
             fontWeight: FontWeight.bold, 
             decoration: TextDecoration.underline, 
             color: Colors.black)),
        onTap: () {
          //menu.dart
        }
    ));
  }

  Widget divisor(){ // solo un divisor
    return Container(
      padding: const EdgeInsets.only(top:20),
      child: Row( children: [
          Expanded(child: Divider(height: 1)),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text('0'),
          ),
          Expanded(child: Divider(height: 1.0)),
    ]));
  }
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal:16),
        decoration: BoxDecoration(color: Colors.black45),
        child: ListView(
          children: [
            Image.asset('assets/PUMAHOME4.png', //LOGO
            height: 250,
            ),
            crearEmail(),
            crearContra(),
            crearBoton(),
            crearLinkCuenta(),
            divisor(),
    ]),),);
  }
}
