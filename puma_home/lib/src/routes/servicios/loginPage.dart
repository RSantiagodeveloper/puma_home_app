import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/src/routes/alumno/menu_stdn.dart';
import 'package:puma_home/src/routes/profesor/menu_tch.dart';
import 'package:puma_home/src/routes/servicios/registro.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contraController = TextEditingController();

  String _userTest = 'ricardo@comunidad.unam.mx';
  String _passTest = 'hola1234';
  String _userType = 'teacher';

  GlobalKey<FormState> _keyForm = new GlobalKey();

  Widget crearEmail() {
    //crea formato Email
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'Usuario o Email'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Campo obligatorio';
          }
          return null;
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
        validator: (value) {
          if (value.isEmpty) {
            return 'Campo obligatorio';
          }
          return null;
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
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 6,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFF040367),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 5, color: Color(0xFFBEAF2A))),
            child: FlatButton(
              child: Text(
                'Entrar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_keyForm.currentState.validate()) {
                  print(
                      'Recibi: ${_emailController.text} y ${_contraController.text}');
                  /**
                   * para hacer la autentificacion se recomiendan los pasos
                   * 1 - verifica que el correo y contraseña existen en el registro de ususarios, ademas comprueba que sean correctas
                   * 2 - si se valida el paso anterior, entonces hay que consultar el rol del usuario
                   *  2.1 - si su rol dice teacher, lo rutea a Menu(usr_id) y le comparte el ID de ususario
                   *  2.2 - si su rol dice student, lo rutea a MenuAlumno(usr_id) y le comparte el ID de ususario
                   * Si no se comprueba el paso 1 o 2, se debe de bloquear el acceso
                   */
                  //caso del login de un alumno
                  if (_emailController.text == _userTest) {
                    if (_contraController.text == _passTest) {
                      if (_userType == 'student') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuAlumno()));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MenuTch()));
                      }
                    } else {
                      _contraController.text = '';
                      _errorDialog('La contraseña es incorrecta');
                    }
                  } else {
                    _emailController.text = '';
                    _contraController.text = '';
                    _errorDialog(
                        'El ususario no existe o la contraseña es incorrecta');
                  }
                }
              }, //deja el acceso en caso de ser correcto****
            )),
      ],
    );
  }

  void _errorDialog(String mensaje) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Acceso denegado'),
            content: Text(
              '$mensaje',
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
                      style: TextStyle(fontSize: 14, color: Colors.blue),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistryPage()));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(children: [
          Container(
            height: MediaQuery.of(context).size.height / 10,
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
