/**Este archivo solo es tomando de referencia al login desarrollado por Rich_cam*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/confiReg.dart';

class RegistryPage extends StatefulWidget {
  _RegistryPageState createState() => _RegistryPageState();
}

// **** -falta tocar cosas
class _RegistryPageState extends State<RegistryPage> {
  //variables para el tema de la pantalla
  int bgColor = 0xFF040367;
  int borderColor = 0xFFBEAF2A;

  TextEditingController _lastName = new TextEditingController();
  TextEditingController _mLastName = new TextEditingController();
  TextEditingController _usrName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _passwdUsr = new TextEditingController();
  TextEditingController _passwdUsrCheck = new TextEditingController();
  TextEditingController _keyComunity = new TextEditingController();

  String rolUser = 'teacher';

  GlobalKey<FormState> keyForm = new GlobalKey();

  Widget usrNameField() {
    //campo para almacenar el nombre
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _usrName,
        decoration: InputDecoration(
          labelText: 'Nombre',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Rellenar campo obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget lastNameField() {
    //campo para el apellido paterno
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _lastName,
        decoration: InputDecoration(labelText: 'Ap_Paterno'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Rellenar campo obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget mLastNameField() {
    //campo para el apellido materno
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _mLastName,
        decoration: InputDecoration(labelText: 'Ap_Materno'),
      ),
    );
  }

  Widget emailField() {
    //campo para el email
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _email,
        decoration: InputDecoration(labelText: 'correo'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Rellenar campo obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget passwdField() {
    //Crea formato Contraseña
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _passwdUsr,
        decoration: InputDecoration(
            labelText: 'password',
            hintText: '8 caracteres min con almenos 2 especiales'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Rellenar campo obligatorio';
          } else if (value.length < 8) {
            return 'contraseña demasiado corta';
          }
          return null;
        },
        obscureText: true,
      ),
    );
  }

  Widget passwdCheckField() {
    //Crea formato Contraseña
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _passwdUsrCheck,
        decoration: InputDecoration(labelText: 'confirme pass'),
        validator: (value) {
          if (value != _passwdUsr.text) {
            return 'Las contraseñas no coinciden';
          }
          return null;
        },
        obscureText: true,
      ),
    );
  }

  Widget userType() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Cómo me deseo registrar',
            style: TextStyle(fontSize: 20),
          ),
          RadioListTile(
              title: Text('Soy profesor'),
              value: 'teacher',
              groupValue: rolUser,
              onChanged: (value) {
                setState(() {
                  rolUser = value;
                });
              }),
          RadioListTile(
              title: Text('Soy Estudiante'),
              value: 'student',
              groupValue: rolUser,
              onChanged: (value) {
                setState(() {
                  rolUser = value;
                });
              })
        ],
      ),
    );
  }

  Widget keyComunityField() {
    //campo para el email
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextFormField(
        controller: _keyComunity,
        decoration: InputDecoration(
            labelText: 'clave de Comunidad UNAM',
            hintText: 'No Cuenta o RFC profesor'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Rellenar campo obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget crearBoton(BuildContext context) {
    // Crea el Boton de Enviar
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 6.67,
      decoration: BoxDecoration(
        color: Color(bgColor),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 5, color: Color(borderColor))
      ),
      child: FlatButton(
        child: Text(
          'Entrar',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (keyForm.currentState.validate()) {
            print(
                'Recibi ${_usrName.text} ${_lastName.text} ${_mLastName.text} ${_email.text} ${_passwdUsr.text} $rolUser ${_keyComunity.text}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuccessRegPage(_usrName.text)));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Form(
        key: keyForm,
        child: new ListView(
          children: <Widget>[
            usrNameField(),
            lastNameField(),
            mLastNameField(),
            passwdField(),
            passwdCheckField(),
            userType(),
            keyComunityField(),
            Divider(),
            crearBoton(context),
          ],
        ),
      ),
    );
  }
}
