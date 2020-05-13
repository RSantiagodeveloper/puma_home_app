//@David Guerrero
//Pantall

import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'menu_stdn.dart';
import 'package:flutter/cupertino.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAlumno(),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Inscripción', style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
    );
  }

class AltaClase extends StatefulWidget {
  _AltaClaseState createState() => _AltaClaseState();
}

class _AltaClaseState extends State<AltaClase> {
 
  TextEditingController _codigoController = new TextEditingController();
  TextEditingController _confirmaCodigoController = new TextEditingController();

  String rolUser = 'Estudiante';

  GlobalKey<FormState> _keyForm = new GlobalKey();

  Widget createCodigoInput() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6.67,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _codigoController,
        decoration: InputDecoration(
          labelText: 'Codigo',
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

  Widget createConfirma() {
    //Crea formato Contraseña
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6.67,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _confirmaCodigoController,
        decoration: InputDecoration(labelText: 'Confirme Código'),
        validator: (value) {
          if (value != _codigoController.text) {
            return 'Los codigos no coinciden';
          }
          return null;
        },
      ),
    );
  }

  Widget createLoginButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 6.67,
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FlatButton(
        child: Text(
          'Alta',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (_keyForm.currentState.validate()) {
            print(
                'Recibi ${_codigoController.text} y ${_confirmaCodigoController.text} $rolUser');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MenuAppStdn()));
          }
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context){
    return Container(
      key: _keyForm,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView(
        children: [
          createCodigoInput(),
          createConfirma(),
          Divider(),
          createLoginButton(context),
        ],
      )
    );
  }

}
