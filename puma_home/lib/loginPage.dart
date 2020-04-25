import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/men%C3%BA.dart';
import 'package:puma_home/registro.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _contraController = TextEditingController();

  GlobalKey<FormState> _keyForm = new GlobalKey();


  Widget crearEmail() {
    //crea formato Email
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'Usuario o Email'),
        validator: (value){
          if(value.isEmpty){
            return 'Campo obligatorio';
          }
        },
      ),
    );
  }

  Widget crearContra() {
    //Crea formato Contraseña
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: TextFormField(
        controller: _contraController,
        decoration: InputDecoration(labelText: 'Contraseña'),
        obscureText: true,
        validator: (value){
          if(value.isEmpty){
            return 'Campo obligatorio';
          }
        },
      ),
    );
  }

  Widget crearBoton(BuildContext context) {
    // Crea el Boton de Enviar
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/6,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF040367),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 5, color: Color(0xFFBEAF2A))
            ),
            child: FlatButton(
              child: Text('Entrar', style: TextStyle(color: Colors.white),),
              onPressed: () {
                if(_keyForm.currentState.validate()){
                  print('Recibi: ${_emailController.text} y ${_contraController.text}');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Menu()));
                }
              }, //deja el acceso en caso de ser correcto****
            )),
      ],
    );
  }

  Widget crearLinkCuenta() {
    //Crea el link al menu para registrar****
    return Container(
        padding: const EdgeInsets.only(top: 6, right: 8),
        child: GestureDetector(
            child: Text("o crea tu cuenta aqui",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.black)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistryPage()));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(children: [
          Container(
            height: MediaQuery.of(context).size.height/10,
          ),
          crearEmail(),
          crearContra(),
          crearBoton(context),
          crearLinkCuenta(),
        ]),
      ),
    );
  }
}
