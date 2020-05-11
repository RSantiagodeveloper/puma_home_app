import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/routes/alumno/mi_perfil_stdn.dart';
import 'package:puma_home/src/routes/alumno/mis_grupos_stdn.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'alta_Grupo.dart';

//
class MenuAlumno extends StatelessWidget {
  final int bgColor = 0xFF040367;
  final int borderColor = 0xFFBEAF2A;
  final double widthBorder = 5.0;

  Widget createVerGruposButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: widthBorder, color: Color(borderColor)),
            borderRadius: BorderRadius.circular(20),
            color: Color(bgColor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Ver mis grupos'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisGrupos()),
            );
          },
        ));
  }

  Widget createMiPerfilButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: widthBorder, color: Color(borderColor)),
            borderRadius: BorderRadius.circular(20),
            color: Color(bgColor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Mi perfil'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MiPerfilStdn('userX')),
            );
          },
        ));
  }

  Widget createAltaButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: widthBorder, color: Color(borderColor)),
            borderRadius: BorderRadius.circular(20),
            color: Color(bgColor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Alta de clases'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AltaClase()),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppStdn(),
      appBar: AppBar(
        backgroundColor: Color(bgColor),
        title: Text('Administración (Alumno)',
            style: TextStyle(color: Color(borderColor))),
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
              Divider(),
              createVerGruposButton(context),
              Divider(),
              createMiPerfilButton(context),
              Divider(),
              createAltaButton(context),
            ],
          )),
    );
  }
}
