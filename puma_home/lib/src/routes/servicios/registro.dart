/*
 * @author: Ricardo_Santiago, Anibal_Medina.
 * @desciption: Archivo dedicado a la creacion del formulario de registro
 * y la conexion con los servicios de autentificacion y cloud_firestore
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/src/routes/servicios/confiReg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

class RegistryPage extends StatefulWidget {
  _RegistryPageState createState() => _RegistryPageState();
}

class _RegistryPageState extends State<RegistryPage> {

  //Referencia a la base de datos 
  final _registryrUsr = FirebaseAuth.instance;
  final fireReference = Firestore.instance;

  //variables para el tema de la pantalla

  TextEditingController _lastName = new TextEditingController();
  TextEditingController _mLastName = new TextEditingController();
  TextEditingController _usrName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _passwdUsr = new TextEditingController();
  TextEditingController _passwdUsrCheck = new TextEditingController();
  TextEditingController _keyComunity = new TextEditingController();

  String rolUser = 'teacher';

  //Ejemplos de consulta para validar registro
  String _noCtaUNAMexample = '310291322';
  String _clvProfUNAMexample = 'SRAA-2041a';

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
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FlatButton(
        child: Text(
          'Registrarme',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async{
          if (keyForm.currentState.validate()) {
            print(
                'Recibi ${_usrName.text} ${_lastName.text} ${_mLastName.text} ${_email.text} ${_passwdUsr.text} $rolUser ${_keyComunity.text}');
            if (rolUser == 'student') {
              if (_keyComunity.text == _noCtaUNAMexample) {
                try{
                  final newUser = await _registryrUsr.createUserWithEmailAndPassword(email: _email.text, password: _passwdUsr.text);
                  if(newUser != null){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessRegPage(_usrName.text)));
                  }
                }catch(e){
                  print(e);
                }
              } else {
                _showDialog('Estudiante', _keyComunity.text);
              }
            } else if (rolUser == 'teacher') {
              if (_keyComunity.text == _clvProfUNAMexample) {
                try{
                  final newUser = await _registryrUsr.createUserWithEmailAndPassword(email: _email.text, password: _passwdUsr.text);
                  fireReference.collection('Usuarios').document(newUser.user.uid).setData({
                    'Nombre': _usrName.text,
                    'ApPat': _lastName.text,
                    'ApMat': _mLastName.text,
                    'Email': _email.text,
                    'Passwd': _passwdUsr.text,
                    'RolUser': rolUser
                  });
                  if(newUser != null){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessRegPage(_usrName.text)));
                  }
                }catch(e){
                  print(e);
                }
              } else {
                _showDialog('Profesor', _keyComunity.text);
              }
            }
          }
        },
      ),
    );
  }

//HANIBAL SE LA COME
//CON PAPAS Y REFRESCO

  void _showDialog(String tipo, String clave) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('aviso'),
            content: Text(
              'No se reconcio al $tipo con clave de comunidad $clave, verifique los datos',
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: GestureDetector(
                    child: Text(
                      'Aceptar',
                      style: TextStyle(fontSize: 14, color: Color(Elementos.contenedor)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ))
                ],
              )
            ],
          );
        });
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
            emailField(),
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
