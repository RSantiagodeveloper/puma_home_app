/*
 * @authors: Ricardo_S, Anibal_M, David_G, @Ricardo_J
 * @description: pantalla dedicada a mostrar el formulario de login
 * el cual, a travez de los servicios de Firebase_Auth y Cloud_Firestore
 * validara al usuario que desee ingresar a la app
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puma_home/src/routes/alumno/menu_stdn.dart';
import 'package:puma_home/src/routes/profesor/menu_tch.dart';
import 'package:puma_home/src/routes/servicios/registro.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  //referencias a los servicios de Backend Firebase_auth y Colud_firestore respectivamente
  final _auth = FirebaseAuth.instance;
  final dbReference = Firestore.instance;
  
  //Controladores de los campos de texto del formulario
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
        keyboardType: TextInputType.emailAddress,
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

  /*
   * @Method: crearBoton
   * @Param: BuildContext
   * @description: Metodo dedicado a crear el boton de ingreso y a validar datos en el formulario de login
   * Verificando que se cumplan con los valores de entrada requeridos, y que activa eventos de error cuando
   * no se cumplen con las condiciones de las cadenas de entrada, o no se identifica al usuario por x razon
   * (email invalido, usuario no existente, pass incorrecta). Ademas, se encarga de enviar los datos
   * correspondientes a la pantalla de admon.
   */
  Widget crearBoton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 6,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(Elementos.contenedor),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 5, color: Color(Elementos.bordes))),
            child: FlatButton(
                child: Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_keyForm.currentState.validate()) {
                  /** Algoritmo de Ingreso
                   * para hacer la autentificacion se recomiendan los pasos
                   * 1 - verifica que el correo y contraseña existen en el registro de ususarios, ademas comprueba que sean correctas
                   * 2 - si se valida el paso anterior, entonces hay que consultar el rol del usuario
                   *  2.1 - si su rol dice teacher, lo rutea a Menu(usr_id) y le comparte el ID de ususario
                   *  2.2 - si su rol dice student, lo rutea a MenuAlumno(usr_id) y le comparte el ID de ususario
                   * Si no se comprueba el paso 1 o 2, se debe de bloquear el acceso
                   */
                    //caso del login de un alumno
                    //bloque try-catch para manejar eventos de error generados por el servicio de Auth
                    try{
                      //validacion mediante email y passwd
                      final userLoged = await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _contraController.text);
                      if(userLoged != null){ //si hay respuesta del servidor
                        final String usrID = userLoged.user.uid;
                        //recuperamos el UID del usuario autenticado y accedemos a su Document en la coleccion usuario
                        var data = await dbReference.collection('Usuarios').document(usrID).get().then((DocumentSnapshot ds){
                          Map<String, dynamic> valor = ds.data; //consultado un solo campo del Documento
                          if (valor['RolUser'] == 'student') { //se verifica el rol del usuario y se decide a que pantalla accede y con que permisos
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuAlumno()));
                            } else {
                              print('Logeando Profesor');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => MenuTch()));
                          }
                        });
                      }
                    }catch(e){
                      //Se verifican los errores arrojados y se muestra un alert para cada caso
                      var errorcode=e.code;
                      var errorMessage = e.message;
                      if(errorcode == 'ERROR_WRONG_PASSWORD'){ //ERROR_WRONG_PASSWORD
                        _errorDialog("Contraseña incorrecta");
                      }
                      else if(errorcode == 'ERROR_INVALID_EMAIL'){ //ERROR_INVALID_EMAIL
                         _errorDialog("Email invalido");
                      }
                      else if(errorcode == 'ERROR_USER_NOT_FOUND'){ //ERROR_USER_NOT_FOUND
                         _errorDialog("Usario no encontrado");
                      }
                                                        
                      else{
                        _errorDialog(errorMessage); //cualquier otro mensaje de error va a aparecer aqui
                      }
                    }
                    
                  }
                })),
      ],
    );
  }
  //widget que muestra un dialogo con un mensaje de error.
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
    //Enlace al form de registro
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
