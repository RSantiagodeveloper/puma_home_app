import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/alumno/pantalla_Grupo_stdn.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';

class Contacto extends StatelessWidget {
  Widget createMenuButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 40),
        child: RaisedButton(
          textColor: Colors.black,
          child: Text('Pantalla Grupo'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PantallaGrupoS('userX', 'grpY')));
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppStdn(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Contacto'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              createMenuButton(context),
            ],
          )),
    );
  }
}
